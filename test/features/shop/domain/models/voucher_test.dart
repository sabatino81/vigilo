import 'package:test/test.dart';
import 'package:vigilo/features/shop/domain/models/voucher.dart';

void main() {
  group('Voucher.isExpired', () {
    test('true when expiresAt is in the past', () {
      final voucher = Voucher(
        id: 'v1',
        code: 'CODE-1',
        productName: 'Amazon 25 EUR',
        valueEur: 25,
        issuedAt: DateTime(2024, 1, 1),
        expiresAt: DateTime(2024, 6, 1), // past
      );
      expect(voucher.isExpired, isTrue);
    });

    test('false when expiresAt is in the future', () {
      final voucher = Voucher(
        id: 'v2',
        code: 'CODE-2',
        productName: 'Amazon 25 EUR',
        valueEur: 25,
        issuedAt: DateTime(2025, 1, 1),
        expiresAt: DateTime(2030, 1, 1), // future
      );
      expect(voucher.isExpired, isFalse);
    });
  });

  group('Voucher.isValid', () {
    test('true when not used and not expired', () {
      final voucher = Voucher(
        id: 'v1',
        code: 'CODE-1',
        productName: 'Test',
        valueEur: 25,
        issuedAt: DateTime(2025, 1, 1),
        expiresAt: DateTime(2030, 1, 1),
      );
      expect(voucher.isValid, isTrue);
    });

    test('false when used', () {
      final voucher = Voucher(
        id: 'v2',
        code: 'CODE-2',
        productName: 'Test',
        valueEur: 25,
        issuedAt: DateTime(2025, 1, 1),
        expiresAt: DateTime(2030, 1, 1),
        isUsed: true,
      );
      expect(voucher.isValid, isFalse);
    });

    test('false when expired', () {
      final voucher = Voucher(
        id: 'v3',
        code: 'CODE-3',
        productName: 'Test',
        valueEur: 25,
        issuedAt: DateTime(2024, 1, 1),
        expiresAt: DateTime(2024, 6, 1),
      );
      expect(voucher.isValid, isFalse);
    });
  });

  group('Voucher.formattedValue', () {
    test('formats without decimals', () {
      final voucher = Voucher(
        id: 'v1',
        code: 'C',
        productName: 'T',
        valueEur: 25,
        issuedAt: DateTime(2025, 1, 1),
        expiresAt: DateTime(2030, 1, 1),
      );
      expect(voucher.formattedValue, '25 EUR');
    });
  });

  group('Voucher.fromJson', () {
    test('parses complete JSON', () {
      final json = {
        'id': 'v1',
        'code': 'AMZ-X8K2P',
        'product_name': 'Buono Amazon 25 EUR',
        'value_eur': 25.0,
        'issued_at': '2025-01-01T00:00:00Z',
        'expires_at': '2025-12-31T23:59:59Z',
        'is_used': false,
        'barcode': '8012345678901',
      };

      final v = Voucher.fromJson(json);
      expect(v.id, 'v1');
      expect(v.code, 'AMZ-X8K2P');
      expect(v.productName, 'Buono Amazon 25 EUR');
      expect(v.valueEur, 25.0);
      expect(v.isUsed, isFalse);
      expect(v.barcode, '8012345678901');
    });

    test('handles missing optional fields', () {
      final json = {
        'id': 'v2',
      };

      final v = Voucher.fromJson(json);
      expect(v.code, '');
      expect(v.productName, '');
      expect(v.valueEur, 0.0);
      expect(v.isUsed, isFalse);
      expect(v.barcode, isNull);
    });
  });
}
