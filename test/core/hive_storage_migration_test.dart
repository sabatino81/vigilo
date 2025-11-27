import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_app_template/core/storage/hive_storage.dart';
import 'package:flutter_app_template/core/utils/secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late MockSecureStorage mockSecure;

  setUp(() async {
    mockSecure = MockSecureStorage();
    SecureStorage.instance = mockSecure;
    await setUpTestHive();
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  test('rotateKey migrates box and updates stored key', () async {
    // existing key
    final oldKey = Uint8List.fromList(List<int>.filled(32, 1));
    final oldKeyB64 = base64Url.encode(oldKey);
    when(() => mockSecure.read(any())).thenAnswer((_) async => oldKeyB64);

    // open box with old key and put data
    final oldCipher = HiveAesCipher(oldKey);
    final box = await Hive.openBox<int>(
      'migrate_box',
      encryptionCipher: oldCipher,
    );
    await box.put('a', 42);
    await box.close();

    // capture writes to secure storage
    when(() => mockSecure.write(any(), any())).thenAnswer((_) async {});

    await HiveStorage.rotateKey(['migrate_box']);

    // verify secure storage write called to update key at least once
    verify(() => mockSecure.write(any(), any())).called(greaterThan(0));
  });
}
