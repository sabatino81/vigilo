import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/shop/data/order_repository.dart';
import 'package:vigilo/features/shop/data/product_repository.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';
import 'package:vigilo/features/shop/domain/models/order.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/voucher.dart';

// ============================================================
// Repository providers
// ============================================================

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.watch(supabaseClientProvider));
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref.watch(supabaseClientProvider));
});

// ============================================================
// Products provider (catalogo)
// ============================================================

final productsProvider =
    AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  ProductsNotifier.new,
);

class ProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    try {
      final repo = ref.read(productRepositoryProvider);
      return await repo.getProducts();
    } on Object {
      return Product.mockProducts();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(productRepositoryProvider);
      return repo.getProducts();
    });
  }
}

// ============================================================
// Cart provider (stato locale, in-memory)
// ============================================================

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addProduct(Product product) {
    final idx = state.indexWhere((c) => c.product.id == product.id);
    if (idx >= 0) {
      final updated = List<CartItem>.from(state);
      updated[idx] = updated[idx].copyWith(
        quantity: updated[idx].quantity + 1,
      );
      state = updated;
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeProduct(String productId) {
    state = state.where((c) => c.product.id != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }
    final updated = state.map((c) {
      if (c.product.id == productId) {
        return c.copyWith(quantity: quantity);
      }
      return c;
    }).toList();
    state = updated;
  }

  void clear() => state = [];

  double get totalEur =>
      state.fold(0.0, (sum, item) => sum + item.subtotal);

  int get itemCount =>
      state.fold(0, (sum, item) => sum + item.quantity);
}

// ============================================================
// Checkout provider (preview breakdown)
// ============================================================

final checkoutProvider =
    AsyncNotifierProvider<CheckoutNotifier, Map<String, dynamic>?>(
  CheckoutNotifier.new,
);

class CheckoutNotifier extends AsyncNotifier<Map<String, dynamic>?> {
  @override
  Future<Map<String, dynamic>?> build() async {
    return null;
  }

  /// Calcola preview checkout dal carrello corrente.
  Future<Map<String, dynamic>?> calculate() async {
    final cart = ref.read(cartProvider);
    if (cart.isEmpty) return null;

    try {
      final repo = ref.read(orderRepositoryProvider);
      final result = await repo.calculateCheckout(
        productIds: cart.map((c) => c.product.id).toList(),
        quantities: cart.map((c) => c.quantity).toList(),
      );
      state = AsyncValue.data(result);
      return result;
    } on Object {
      return null;
    }
  }

  /// Piazza ordine.
  Future<Map<String, dynamic>?> placeOrder({bool useBnpl = false}) async {
    final cart = ref.read(cartProvider);
    if (cart.isEmpty) return null;

    try {
      final repo = ref.read(orderRepositoryProvider);
      final result = await repo.placeOrder(
        productIds: cart.map((c) => c.product.id).toList(),
        quantities: cart.map((c) => c.quantity).toList(),
        useBnpl: useBnpl,
      );

      if (result['success'] == true) {
        ref.read(cartProvider.notifier).clear();
        ref.invalidate(ordersProvider);
      }

      return result;
    } on Object {
      return null;
    }
  }
}

// ============================================================
// Orders provider (storico)
// ============================================================

final ordersProvider =
    AsyncNotifierProvider<OrdersNotifier, List<Order>>(
  OrdersNotifier.new,
);

class OrdersNotifier extends AsyncNotifier<List<Order>> {
  @override
  Future<List<Order>> build() async {
    try {
      final repo = ref.read(orderRepositoryProvider);
      return await repo.getMyOrders();
    } on Object {
      return Order.mockOrders();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(orderRepositoryProvider);
      return repo.getMyOrders();
    });
  }
}

// ============================================================
// Vouchers provider
// ============================================================

final vouchersProvider =
    AsyncNotifierProvider<VouchersNotifier, List<Voucher>>(
  VouchersNotifier.new,
);

class VouchersNotifier extends AsyncNotifier<List<Voucher>> {
  @override
  Future<List<Voucher>> build() async {
    try {
      final repo = ref.read(orderRepositoryProvider);
      return await repo.getMyVouchers();
    } on Object {
      return Voucher.mockVouchers();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(orderRepositoryProvider);
      return repo.getMyVouchers();
    });
  }
}
