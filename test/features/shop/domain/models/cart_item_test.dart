import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  group('CartItem', () {
    test('default quantity is 1', () {
      final p = makeProduct(basePrice: 25.0);
      final item = CartItem(product: p, variant: p.defaultVariant);
      expect(item.quantity, 1);
    });

    test('subtotal multiplies displayPrice by quantity', () {
      final p = makeProduct(basePrice: 10.0);
      final item = CartItem(
        product: p,
        variant: p.defaultVariant,
        quantity: 3,
      );
      expect(item.subtotal, closeTo(30.0, 0.001));
    });

    test('subtotal uses promo price when product has promo', () {
      final p = makeProduct(basePrice: 100.0, promoDiscountPercent: 20);
      final item = CartItem(
        product: p,
        variant: p.defaultVariant,
        quantity: 2,
      );
      // variantDisplayPrice = 100 * (1 - 20/100) = 80
      // subtotal = 80 * 2 = 160
      expect(item.subtotal, closeTo(160.0, 0.001));
    });

    test('subtotal with no promo uses basePrice', () {
      final p = makeProduct(basePrice: 45.50);
      final item = CartItem(
        product: p,
        variant: p.defaultVariant,
      );
      expect(item.subtotal, closeTo(45.50, 0.001));
    });

    test('formattedSubtotal formats with 2 decimals and EUR', () {
      final p = makeProduct(basePrice: 12.5);
      final item = CartItem(
        product: p,
        variant: p.defaultVariant,
        quantity: 3,
      );
      // 12.5 * 3 = 37.5
      expect(item.formattedSubtotal, '37.50 EUR');
    });

    test('formattedSubtotal handles whole numbers', () {
      final p = makeProduct(basePrice: 10.0);
      final item = CartItem(
        product: p,
        variant: p.defaultVariant,
      );
      expect(item.formattedSubtotal, '10.00 EUR');
    });

    test('copyWith changes quantity', () {
      final p = makeProduct(basePrice: 20.0);
      final original = CartItem(
        product: p,
        variant: p.defaultVariant,
      );
      final updated = original.copyWith(quantity: 5);
      expect(updated.quantity, 5);
      expect(updated.subtotal, closeTo(100.0, 0.001));
    });

    test('copyWith preserves product and variant', () {
      final product = makeProduct(id: 'special', basePrice: 33.0);
      final original = CartItem(
        product: product,
        variant: product.defaultVariant,
        quantity: 2,
      );
      final updated = original.copyWith(quantity: 4);
      expect(updated.product.id, 'special');
      expect(updated.product.basePrice, 33.0);
      expect(updated.variant.id, original.variant.id);
    });

    test('copyWith without arguments preserves quantity', () {
      final p = makeProduct();
      final original = CartItem(
        product: p,
        variant: p.defaultVariant,
        quantity: 7,
      );
      final updated = original.copyWith();
      expect(updated.quantity, 7);
    });

    test('cartKey returns variant id', () {
      final v = makeVariant(id: 'v_123');
      final item = CartItem(
        product: makeProduct(),
        variant: v,
      );
      expect(item.cartKey, 'v_123');
    });

    test('uses variant price override when set', () {
      final p = makeProduct(basePrice: 50.0);
      final v = makeVariant(id: 'v_override', price: 75.0);
      final item = CartItem(product: p, variant: v, quantity: 2);
      // effectivePrice = 75.0 (override), subtotal = 75 * 2 = 150
      expect(item.subtotal, closeTo(150.0, 0.001));
    });
  });
}
