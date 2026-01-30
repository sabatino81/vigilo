import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/product_badge.dart';
import 'package:vigilo/features/shop/domain/models/product_category.dart';

void main() {
  Product _product({
    double basePrice = 100.0,
    int? promoDiscountPercent,
    ProductBadge badge = ProductBadge.none,
    ProductCategory category = ProductCategory.casa,
  }) {
    return Product(
      id: 'test_1',
      name: 'Test Product',
      description: 'A test product',
      category: category,
      basePrice: basePrice,
      emoji: '🎁',
      badge: badge,
      promoDiscountPercent: promoDiscountPercent,
    );
  }

  group('Product.displayPrice', () {
    test('returns basePrice when no promo', () {
      final product = _product(basePrice: 50.0);
      expect(product.displayPrice, 50.0);
    });

    test('applies percentage discount', () {
      final product = _product(basePrice: 28.90, promoDiscountPercent: 15);
      // 28.90 * (1 - 0.15) = 28.90 * 0.85 = 24.565
      expect(product.displayPrice, closeTo(24.565, 0.001));
    });

    test('returns basePrice when promo is 0', () {
      final product = _product(basePrice: 50.0, promoDiscountPercent: 0);
      expect(product.displayPrice, 50.0);
    });

    test('returns basePrice when promo is null', () {
      final product = _product(basePrice: 50.0, promoDiscountPercent: null);
      expect(product.displayPrice, 50.0);
    });
  });

  group('Product.hasPromo', () {
    test('true when promoDiscountPercent > 0', () {
      final product = _product(promoDiscountPercent: 10);
      expect(product.hasPromo, true);
    });

    test('false when null', () {
      final product = _product(promoDiscountPercent: null);
      expect(product.hasPromo, false);
    });

    test('false when 0', () {
      final product = _product(promoDiscountPercent: 0);
      expect(product.hasPromo, false);
    });
  });

  group('Product.formattedPrice / formattedBasePrice', () {
    test('formats with 2 decimals and EUR', () {
      final product = _product(basePrice: 65.0);
      expect(product.formattedPrice, '65.00 EUR');
      expect(product.formattedBasePrice, '65.00 EUR');
    });
  });

  group('Product.fromJson', () {
    test('parses complete JSON', () {
      final json = <String, dynamic>{
        'id': 'prod_1',
        'name': 'Lampada LED',
        'description': 'Una lampada',
        'category': 'tech',
        'base_price': 28.90,
        'emoji': '💡',
        'badge': 'scontato',
        'promo_discount_percent': 15,
        'supplier_name': 'BigBuy',
      };

      final product = Product.fromJson(json);

      expect(product.id, 'prod_1');
      expect(product.name, 'Lampada LED');
      expect(product.description, 'Una lampada');
      expect(product.category, ProductCategory.tech);
      expect(product.basePrice, 28.90);
      expect(product.emoji, '💡');
      expect(product.badge, ProductBadge.scontato);
      expect(product.promoDiscountPercent, 15);
      expect(product.supplierName, 'BigBuy');
    });

    test('defaults missing fields', () {
      final json = <String, dynamic>{
        'id': 'prod_2',
      };

      final product = Product.fromJson(json);

      expect(product.name, '');
      expect(product.description, '');
      expect(product.category, ProductCategory.casa);
      expect(product.basePrice, 0.0);
      expect(product.emoji, '🎁');
      expect(product.badge, ProductBadge.none);
      expect(product.promoDiscountPercent, isNull);
      expect(product.supplierName, isNull);
    });

    test('unknown category defaults to casa', () {
      final json = <String, dynamic>{
        'id': 'prod_3',
        'category': 'unknown_category',
      };

      final product = Product.fromJson(json);
      expect(product.category, ProductCategory.casa);
    });

    test('unknown badge defaults to none', () {
      final json = <String, dynamic>{
        'id': 'prod_4',
        'badge': 'unknown_badge',
      };

      final product = Product.fromJson(json);
      expect(product.badge, ProductBadge.none);
    });
  });
}
