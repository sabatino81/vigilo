import 'package:vigilo/features/shop/domain/models/product.dart';

/// Elemento nel carrello
class CartItem {
  const CartItem({
    required this.product,
    this.quantity = 1,
  });

  final Product product;
  final int quantity;

  double get subtotal => product.displayPrice * quantity;

  String get formattedSubtotal => '${subtotal.toStringAsFixed(2)} EUR';

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}
