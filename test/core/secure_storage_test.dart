import 'package:vigilo/core/utils/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureStorage secureStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    secureStorage = SecureStorage(storage: mockStorage);
  });

  test('write delegates to FlutterSecureStorage', () async {
    when(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});

    await secureStorage.write('k', 'v');

    verify(() => mockStorage.write(key: 'k', value: 'v')).called(1);
  });

  test('read delegates to FlutterSecureStorage', () async {
    when(
      () => mockStorage.read(key: any(named: 'key')),
    ).thenAnswer((_) async => 'v');

    final res = await secureStorage.read('k');

    expect(res, 'v');
    verify(() => mockStorage.read(key: 'k')).called(1);
  });

  test('delete delegates to FlutterSecureStorage', () async {
    when(
      () => mockStorage.delete(key: any(named: 'key')),
    ).thenAnswer((_) async {});

    await secureStorage.delete('k');

    verify(() => mockStorage.delete(key: 'k')).called(1);
  });

  test('clear delegates to FlutterSecureStorage', () async {
    when(() => mockStorage.deleteAll()).thenAnswer((_) async {});

    await secureStorage.clear();

    verify(() => mockStorage.deleteAll()).called(1);
  });
}
