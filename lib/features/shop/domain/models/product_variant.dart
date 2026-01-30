/// Variante di un prodotto (taglia, colore, ecc.)
/// Ogni prodotto ha sempre almeno 1 variante ("Standard" per prodotti semplici).
class ProductVariant {
  const ProductVariant({
    required this.id,
    required this.variantLabel,
    this.attributes = const {},
    this.price,
    this.imageUrl,
    this.supplierSku,
    this.stockStatus = 'available',
  });

  final String id;
  final String variantLabel;
  final Map<String, dynamic> attributes;

  /// Prezzo override. Se null, usa basePrice del prodotto padre.
  final double? price;

  /// Immagine variante. Se null, usa imageUrl del prodotto padre.
  final String? imageUrl;

  final String? supplierSku;

  /// 'available', 'out_of_stock', 'on_demand'
  final String stockStatus;

  bool get isAvailable => stockStatus == 'available';
  bool get isStandard => variantLabel == 'Standard' && attributes.isEmpty;

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] as String,
      variantLabel: json['variant_label'] as String? ?? 'Standard',
      attributes:
          (json['attributes'] as Map<String, dynamic>?) ?? const {},
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      supplierSku: json['supplier_sku'] as String?,
      stockStatus: json['stock_status'] as String? ?? 'available',
    );
  }
}
