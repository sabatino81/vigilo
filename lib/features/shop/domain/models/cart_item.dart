import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/product_variant.dart';

/// Elemento nel carrello — sempre con variante selezionata
class CartItem {
  const CartItem({
    required this.product,
    required this.variant,
    this.quantity = 1,
  });

  final Product product;
  final ProductVariant variant;
  final int quantity;

  /// Chiave univoca per deduplicazione nel carrello
  String get cartKey => variant.id;

  /// Prezzo unitario (variante + promo)
  double get unitPrice => product.variantDisplayPrice(variant);

  double get subtotal => unitPrice * quantity;

  String get formattedSubtotal => '${subtotal.toStringAsFixed(2)} EUR';

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      variant: variant,
      quantity: quantity ?? this.quantity,
    );
  }
}
