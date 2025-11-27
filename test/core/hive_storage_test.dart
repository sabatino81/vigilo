import 'dart:convert';

import 'package:flutter_app_template/core/storage/hive_storage.dart';
import 'package:flutter_app_template/core/utils/secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
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

  test('generates a 32-byte key when none exists', () async {
    when(() => mockSecure.read(any())).thenAnswer((_) async => null);
    when(() => mockSecure.write(any(), any())).thenAnswer((_) async {});

    // Use internal method via reflection-like access isn't possible; instead
    // call openEncryptedBox which will create the key.
    final box = await HiveStorage.openEncryptedBox<int>('test_box_keygen');
    expect(box, isNotNull);
    await box.close();

    verify(() => mockSecure.write(any(), any())).called(1);
  });

  test('reuses existing key when present', () async {
    final key = base64Url.encode(List<int>.filled(32, 42));
    when(() => mockSecure.read(any())).thenAnswer((_) async => key);

    final box = await HiveStorage.openEncryptedBox<int>('test_box_keyreuse');
    expect(box, isNotNull);
    await box.close();

    verifyNever(() => mockSecure.write(any(), any()));
  });
}
