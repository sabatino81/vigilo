import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';
import 'package:vigilo/features/shop/providers/shop_providers.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = createContainer();
  });

  tearDown(() {
    container.dispose();
  });

  CartNotifier notifier() => container.read(cartProvider.notifier);
  List<CartItem> state() => container.read(cartProvider);

  group('CartNotifier initial state', () {
    test('starts with empty list', () {
      expect(state(), isEmpty);
    });
  });

  group('CartNotifier.addToCart', () {
    test('adds new item with quantity 1', () {
      final product = makeProduct(id: 'p1');
      final variant = makeVariant(id: 'v1');
      notifier().addToCart(product, variant);

      expect(state(), hasLength(1));
      expect(state().first.product.id, 'p1');
      expect(state().first.variant.id, 'v1');
      expect(state().first.quantity, 1);
    });

    test('increments quantity for same variant', () {
      final product = makeProduct(id: 'p1');
      final variant = makeVariant(id: 'v1');
      notifier()
        ..addToCart(product, variant)
        ..addToCart(product, variant);

      expect(state(), hasLength(1));
      expect(state().first.quantity, 2);
    });

    test('adds different variants as separate items', () {
      final product = makeProduct(id: 'p1');
      notifier()
        ..addToCart(product, makeVariant(id: 'v1'))
        ..addToCart(product, makeVariant(id: 'v2'));

      expect(state(), hasLength(2));
    });
  });

  group('CartNotifier.removeItem', () {
    test('removes item by variant id', () {
      final p1 = makeProduct(id: 'p1');
      final p2 = makeProduct(id: 'p2');
      notifier()
        ..addToCart(p1, makeVariant(id: 'v1'))
        ..addToCart(p2, makeVariant(id: 'v2'))
        ..removeItem('v1');

      expect(state(), hasLength(1));
      expect(state().first.variant.id, 'v2');
    });

    test('is no-op for unknown id', () {
      final p = makeProduct(id: 'p1');
      notifier()
        ..addToCart(p, makeVariant(id: 'v1'))
        ..removeItem('unknown');

      expect(state(), hasLength(1));
    });
  });

  group('CartNotifier.updateQuantity', () {
    test('changes quantity for existing item', () {
      final p = makeProduct(id: 'p1');
      notifier()
        ..addToCart(p, makeVariant(id: 'v1'))
        ..updateQuantity('v1', 5);

      expect(state().first.quantity, 5);
    });

    test('removes item when quantity <= 0', () {
      final p = makeProduct(id: 'p1');
      notifier()
        ..addToCart(p, makeVariant(id: 'v1'))
        ..updateQuantity('v1', 0);

      expect(state(), isEmpty);
    });
  });

  group('CartNotifier.clear', () {
    test('empties the cart', () {
      notifier()
        ..addToCart(makeProduct(id: 'p1'), makeVariant(id: 'v1'))
        ..addToCart(makeProduct(id: 'p2'), makeVariant(id: 'v2'))
        ..clear();

      expect(state(), isEmpty);
    });
  });

  group('CartNotifier computed', () {
    test('totalEur sums subtotals', () {
      notifier()
        ..addToCart(makeProduct(id: 'p1', basePrice: 10.0), makeVariant(id: 'v1'))
        ..addToCart(makeProduct(id: 'p2', basePrice: 25.0), makeVariant(id: 'v2'));

      expect(notifier().totalEur, 35.0);
    });

    test('itemCount sums quantities', () {
      final p = makeProduct(id: 'p1');
      final v = makeVariant(id: 'v1');
      notifier()
        ..addToCart(p, v)
        ..addToCart(p, v) // qty 2
        ..addToCart(makeProduct(id: 'p2'), makeVariant(id: 'v2')); // qty 1

      expect(notifier().itemCount, 3);
    });
  });
}
