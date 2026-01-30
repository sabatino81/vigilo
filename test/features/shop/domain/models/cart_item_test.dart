import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  group('CartItem', () {
    test('default quantity is 1', () {
      final item = CartItem(product: makeProduct(basePrice: 25.0));
      expect(item.quantity, 1);
    });

    test('subtotal multiplies displayPrice by quantity', () {
      final item = CartItem(
        product: makeProduct(basePrice: 10.0),
        quantity: 3,
      );
      expect(item.subtotal, closeTo(30.0, 0.001));
    });

    test('subtotal uses promo price when product has promo', () {
      final item = CartItem(
        product: makeProduct(basePrice: 100.0, promoDiscountPercent: 20),
        quantity: 2,
      );
      // displayPrice = 100 * (1 - 20/100) = 80
      // subtotal = 80 * 2 = 160
      expect(item.subtotal, closeTo(160.0, 0.001));
    });

    test('subtotal with no promo uses basePrice', () {
      final item = CartItem(
        product: makeProduct(basePrice: 45.50),
        quantity: 1,
      );
      expect(item.subtotal, closeTo(45.50, 0.001));
    });

    test('formattedSubtotal formats with 2 decimals and EUR', () {
      final item = CartItem(
        product: makeProduct(basePrice: 12.5),
        quantity: 3,
      );
      // 12.5 * 3 = 37.5
      expect(item.formattedSubtotal, '37.50 EUR');
    });

    test('formattedSubtotal handles whole numbers', () {
      final item = CartItem(
        product: makeProduct(basePrice: 10.0),
        quantity: 1,
      );
      expect(item.formattedSubtotal, '10.00 EUR');
    });

    test('copyWith changes quantity', () {
      final original = CartItem(
        product: makeProduct(basePrice: 20.0),
        quantity: 1,
      );
      final updated = original.copyWith(quantity: 5);
      expect(updated.quantity, 5);
      expect(updated.subtotal, closeTo(100.0, 0.001));
    });

    test('copyWith preserves product', () {
      final product = makeProduct(id: 'special', basePrice: 33.0);
      final original = CartItem(product: product, quantity: 2);
      final updated = original.copyWith(quantity: 4);
      expect(updated.product.id, 'special');
      expect(updated.product.basePrice, 33.0);
    });

    test('copyWith without arguments preserves quantity', () {
      final original = CartItem(
        product: makeProduct(),
        quantity: 7,
      );
      final updated = original.copyWith();
      expect(updated.quantity, 7);
    });
  });
}
