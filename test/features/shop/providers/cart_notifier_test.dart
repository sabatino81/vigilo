import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/product_category.dart';
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

  group('CartNotifier.addProduct', () {
    test('adds new item with quantity 1', () {
      final product = makeProduct(id: 'p1');
      notifier().addProduct(product);

      expect(state(), hasLength(1));
      expect(state().first.product.id, 'p1');
      expect(state().first.quantity, 1);
    });

    test('increments quantity for existing product', () {
      final product = makeProduct(id: 'p1');
      notifier()
        ..addProduct(product)
        ..addProduct(product);

      expect(state(), hasLength(1));
      expect(state().first.quantity, 2);
    });

    test('adds different products as separate items', () {
      notifier()
        ..addProduct(makeProduct(id: 'p1'))
        ..addProduct(makeProduct(id: 'p2'));

      expect(state(), hasLength(2));
    });
  });

  group('CartNotifier.removeProduct', () {
    test('removes item by product id', () {
      notifier()
        ..addProduct(makeProduct(id: 'p1'))
        ..addProduct(makeProduct(id: 'p2'))
        ..removeProduct('p1');

      expect(state(), hasLength(1));
      expect(state().first.product.id, 'p2');
    });

    test('is no-op for unknown id', () {
      notifier()
        ..addProduct(makeProduct(id: 'p1'))
        ..removeProduct('unknown');

      expect(state(), hasLength(1));
    });
  });

  group('CartNotifier.updateQuantity', () {
    test('changes quantity for existing item', () {
      notifier()
        ..addProduct(makeProduct(id: 'p1'))
        ..updateQuantity('p1', 5);

      expect(state().first.quantity, 5);
    });

    test('removes item when quantity <= 0', () {
      notifier()
        ..addProduct(makeProduct(id: 'p1'))
        ..updateQuantity('p1', 0);

      expect(state(), isEmpty);
    });
  });

  group('CartNotifier.clear', () {
    test('empties the cart', () {
      notifier()
        ..addProduct(makeProduct(id: 'p1'))
        ..addProduct(makeProduct(id: 'p2'))
        ..clear();

      expect(state(), isEmpty);
    });
  });

  group('CartNotifier computed', () {
    test('totalEur sums subtotals', () {
      notifier()
        ..addProduct(makeProduct(id: 'p1', basePrice: 10.0))
        ..addProduct(makeProduct(id: 'p2', basePrice: 25.0));

      expect(notifier().totalEur, 35.0);
    });

    test('itemCount sums quantities', () {
      final p = makeProduct(id: 'p1');
      notifier()
        ..addProduct(p)
        ..addProduct(p) // qty 2
        ..addProduct(makeProduct(id: 'p2')); // qty 1

      expect(notifier().itemCount, 3);
    });
  });
}
