import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:vigilo/core/utils/secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Helper per inizializzare Hive e abilitare cifratura AES per le box.
class HiveStorage {
  /// Key name usata in FlutterSecureStorage
  static const _kHiveKeyName = 'hive_encryption_key_v1';

  /// Inizializza Hive (chiama Hive.initFlutter) e prepara l'ambiente.
  /// Deve essere chiamato prima di aprire qualsiasi box.
  static Future<void> init() async {
    await Hive.initFlutter();
    // Optionally you could register adapters here if you use TypeAdapters
    if (kDebugMode) {
      // no-op or debug info
    }
  }

  /// Restituisce la chiave AES a 32 byte, creandola e salvandola se necessario.
  static Future<Uint8List> _getOrCreateKey() async {
    final secure = SecureStorage.instance;
    final existing = await secure.read(_kHiveKeyName);
    if (existing != null && existing.isNotEmpty) {
      try {
        final bytes = base64Url.decode(existing);
        if (bytes.length == 32) return Uint8List.fromList(bytes);
      } on Object catch (_) {
        // ignore and recreate key below
      }
    }

    // Generate a new 32-byte key using a secure RNG
    final rnd = Random.secure();
    final key = List<int>.generate(32, (_) => rnd.nextInt(256));
    final keyB64 = base64Url.encode(key);
    await secure.write(_kHiveKeyName, keyB64);
    return Uint8List.fromList(key);
  }

  /// Rotates the AES key: genera una nuova chiave, la salva e migra le box
  /// cifrate fornite in `boxNames` alla nuova chiave.
  /// Nota: questo copia i dati su box temporanee cifrate con la nuova chiave
  /// e poi sovrascrive le originali.
  static Future<void> rotateKey(List<String> boxNames) async {
    final secure = SecureStorage.instance;
    // generate new key
    final rnd = Random.secure();
    final newKey = List<int>.generate(32, (_) => rnd.nextInt(256));
    final newKeyB64 = base64Url.encode(newKey);

    // For each box: open with the old key, read all values and write into a
    // temporary box encrypted with the new key.
    final oldKey = await _getOrCreateKey();
    final oldCipher = HiveAesCipher(oldKey);
    final newCipher = HiveAesCipher(Uint8List.fromList(newKey));
    final tempNames = <String>[];
    try {
      // Step 1: create temp boxes (copy original -> temp)
      for (final name in boxNames) {
        final box = await Hive.openBox<dynamic>(
          name,
          encryptionCipher: oldCipher,
        );
        final tempName = '${name}_migr_tmp';
        final temp = await Hive.openBox<dynamic>(
          tempName,
          encryptionCipher: newCipher,
        );

        for (final k in box.keys) {
          final v = box.get(k);
          await temp.put(k, v);
        }

        await box.close();
        await temp.close();
        tempNames.add(tempName);
      }

      // Step 2: write new key to secure storage (so subsequent opens use it)
      await secure.write(_kHiveKeyName, newKeyB64);

      // Step 3: copy temp -> final boxes. Originals remain until we decide
      // to delete them to avoid data loss during migration.
      for (final name in boxNames) {
        final tempName = '${name}_migr_tmp';
        final temp = await Hive.openBox<dynamic>(
          tempName,
          encryptionCipher: newCipher,
        );
        final migrated = await Hive.openBox<dynamic>(
          name,
          encryptionCipher: newCipher,
        );

        for (final k in temp.keys) {
          final v = temp.get(k);
          await migrated.put(k, v);
        }

        await temp.close();
        final migratedRef = migrated;
        await migratedRef.compact();
        await migratedRef.close();
      }

      // Step 4: cleanup temp boxes
      for (final tn in tempNames) {
        final tb = await Hive.openBox<dynamic>(
          tn,
          encryptionCipher: newCipher,
        );
        await tb.deleteFromDisk();
      }
    } on Object catch (_) {
      // On any failure, attempt to roll back: restore old key if we
      // overwrote it
      try {
        final oldKeyB64 = base64Url.encode(oldKey);
        await secure.write(_kHiveKeyName, oldKeyB64);
      } on Object catch (_) {
        // if rollback failed, log then continue to cleanup
        // optionally: logger.e('Rollback failed', e2);
      }
      // ensure temp boxes removed
      for (final tn in tempNames) {
        try {
          final tb = await Hive.openBox<dynamic>(
            tn,
            encryptionCipher: newCipher,
          );
          await tb.deleteFromDisk();
        } on Object catch (_) {
          // ignore cleanup errors
        }
      }
      rethrow;
    }
  }

  /// Open a Hive box with AES encryption. Returns the opened `Box<T>`.
  static Future<Box<T>> openEncryptedBox<T>(String name) async {
    final key = await _getOrCreateKey();
    final cipher = HiveAesCipher(key);
    return Hive.openBox<T>(name, encryptionCipher: cipher);
  }

  /// Convenience: open an unencrypted box
  static Future<Box<T>> openBox<T>(String name) async {
    return Hive.openBox<T>(name);
  }
}
