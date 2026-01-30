import 'package:vigilo/features/shop/domain/models/product_badge.dart';
import 'package:vigilo/features/shop/domain/models/product_category.dart';

/// Prodotto ecommerce con markup 30% sul costo fornitore
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.basePrice,
    required this.emoji,
    this.badge = ProductBadge.none,
    this.promoDiscountPercent,
    this.supplierName,
  });

  final String id;
  final String name;
  final String description;
  final ProductCategory category;

  /// Prezzo base in EUR (gia' con markup 30%)
  final double basePrice;

  /// Emoji rappresentativa del prodotto
  final String emoji;

  /// Badge speciale
  final ProductBadge badge;

  /// Sconto promo in percentuale (0-100)
  final int? promoDiscountPercent;

  /// Nome fornitore (CJDropshipping, BigBuy, ecc.)
  final String? supplierName;

  /// Prezzo dopo sconto promo
  double get displayPrice {
    if (promoDiscountPercent != null && promoDiscountPercent! > 0) {
      return basePrice * (1 - promoDiscountPercent! / 100);
    }
    return basePrice;
  }

  /// Formatta prezzo in EUR
  String get formattedPrice => '${displayPrice.toStringAsFixed(2)} EUR';

  /// Formatta prezzo base (prima di promo)
  String get formattedBasePrice => '${basePrice.toStringAsFixed(2)} EUR';

  /// Ha uno sconto promo attivo
  bool get hasPromo =>
      promoDiscountPercent != null && promoDiscountPercent! > 0;

  /// Crea da JSON (risposta RPC get_products).
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: _parseCategory(json['category'] as String?),
      basePrice: (json['base_price'] as num?)?.toDouble() ?? 0.0,
      emoji: json['emoji'] as String? ?? '🎁',
      badge: _parseBadge(json['badge'] as String?),
      promoDiscountPercent: json['promo_discount_percent'] as int?,
      supplierName: json['supplier_name'] as String?,
    );
  }

  static ProductCategory _parseCategory(String? value) {
    if (value == null) return ProductCategory.casa;
    return ProductCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ProductCategory.casa,
    );
  }

  static ProductBadge _parseBadge(String? value) {
    if (value == null) return ProductBadge.none;
    return ProductBadge.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ProductBadge.none,
    );
  }

  /// Mock: 12 prodotti su 6 categorie
  static List<Product> mockProducts() {
    return const [
      // Casa
      Product(
        id: 'prod_1',
        name: 'Set Asciugamani Premium',
        description: 'Set di 4 asciugamani in cotone egiziano. '
            'Morbidi e resistenti ai lavaggi.',
        category: ProductCategory.casa,
        basePrice: 32.50,
        emoji: '🛁',
        supplierName: 'BigBuy',
      ),
      Product(
        id: 'prod_2',
        name: 'Lampada LED Smart',
        description: 'Lampada da scrivania con regolazione colore '
            'e intensita. Compatibile Alexa.',
        category: ProductCategory.casa,
        basePrice: 28.90,
        emoji: '💡',
        badge: ProductBadge.scontato,
        promoDiscountPercent: 15,
        supplierName: 'BigBuy',
      ),
      // Abbigliamento
      Product(
        id: 'prod_3',
        name: 'Giacca Softshell',
        description: 'Giacca antivento e idrorepellente. '
            'Ideale per il lavoro.',
        category: ProductCategory.abbigliamento,
        basePrice: 65.00,
        emoji: '🧥',
        supplierName: 'BigBuy',
      ),
      Product(
        id: 'prod_4',
        name: 'Calzini Termici 3 Paia',
        description: 'Calzini termici rinforzati per ambienti '
            'freddi. Pacco da 3.',
        category: ProductCategory.abbigliamento,
        basePrice: 18.90,
        emoji: '🧦',
        badge: ProductBadge.gratis,
        supplierName: 'CJDropshipping',
      ),
      // Tech
      Product(
        id: 'prod_5',
        name: 'Power Bank 20000mAh',
        description: 'Ricarica rapida USB-C, 2 porte. '
            'Resistente agli urti.',
        category: ProductCategory.tech,
        basePrice: 35.90,
        emoji: '🔋',
        supplierName: 'CJDropshipping',
      ),
      Product(
        id: 'prod_6',
        name: 'Auricolari Bluetooth',
        description: 'Auricolari TWS con cancellazione rumore. '
            '24h di autonomia.',
        category: ProductCategory.tech,
        basePrice: 42.50,
        emoji: '🎧',
        badge: ProductBadge.promo,
        promoDiscountPercent: 20,
        supplierName: 'CJDropshipping',
      ),
      // Consumabili
      Product(
        id: 'prod_7',
        name: 'Crema Solare SPF50+',
        description: 'Protezione alta per lavoro all\'aperto. '
            'Resistente al sudore.',
        category: ProductCategory.consumabili,
        basePrice: 14.90,
        emoji: '☀️',
        supplierName: 'BigBuy',
      ),
      Product(
        id: 'prod_8',
        name: 'Kit Primo Soccorso',
        description: 'Kit completo 120 pezzi. Conforme '
            'normativa vigente.',
        category: ProductCategory.consumabili,
        basePrice: 22.50,
        emoji: '🩹',
        supplierName: 'BigBuy',
      ),
      // Sport
      Product(
        id: 'prod_9',
        name: 'Fascia Elastica Set',
        description: 'Set 5 fasce elastiche per stretching '
            'e riscaldamento pre-turno.',
        category: ProductCategory.sport,
        basePrice: 19.90,
        emoji: '🏋️',
        badge: ProductBadge.scontato,
        promoDiscountPercent: 10,
        supplierName: 'CJDropshipping',
      ),
      Product(
        id: 'prod_10',
        name: 'Borraccia Termica 750ml',
        description: 'Acciaio inox, mantiene caldo/freddo '
            '12h. Anti-perdita.',
        category: ProductCategory.sport,
        basePrice: 24.90,
        emoji: '🥤',
        supplierName: 'CJDropshipping',
      ),
      // Voucher
      Product(
        id: 'prod_11',
        name: 'Buono Amazon 25 EUR',
        description: 'Buono regalo Amazon. Codice digitale '
            'via email entro 24h.',
        category: ProductCategory.voucher,
        basePrice: 25.00,
        emoji: '🎁',
        supplierName: 'Tillo',
      ),
      Product(
        id: 'prod_12',
        name: 'Buono Carburante 50 EUR',
        description: 'Buono carburante multimarca. '
            'Valido in tutte le stazioni.',
        category: ProductCategory.voucher,
        basePrice: 50.00,
        emoji: '⛽',
        badge: ProductBadge.gratis,
        supplierName: 'Epipoli',
      ),
    ];
  }
}
