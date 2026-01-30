import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/product_badge.dart';

/// Card prodotto per la griglia catalogo — design moderno con glassmorphism
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.onTap,
    this.onBuyNow,
    this.onAddToCart,
    super.key,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback? onBuyNow;
  final VoidCallback? onAddToCart;

  /// Sconto massimo Punti Elmetto
  static const _maxElmettoDiscount = 0.20;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final elmettoPrice = product.displayPrice * (1 - _maxElmettoDiscount);
    final catColor = product.category.color;

    // Colore bordo in base alla % sconto base
    final borderColor = !product.hasPromo
        ? const Color(0xFFFFB800)
        : product.promoDiscountPercent! >= 20
            ? const Color(0xFFD32F2F) // rosso — sconto forte
            : product.promoDiscountPercent! >= 10
                ? const Color(0xFFFF6D00) // arancione — sconto medio
                : const Color(0xFFFFB800); // giallo — sconto leggero

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: product.hasPromo
                ? borderColor.withValues(alpha: 0.5)
                : borderColor.withValues(alpha: 0.6),
            width: product.hasPromo ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: catColor.withValues(alpha: isDark ? 0.15 : 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const Color(0xFF2A2A2A),
                      const Color(0xFF1E1E1E),
                    ]
                  : [
                      Colors.white,
                      const Color(0xFFF8F8F8),
                    ],
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
          children: [
            // Sfondo con emoji grande
            Positioned.fill(
              child: Container(
                color: const Color(0xFFEEEEEE),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  product.emoji,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),

            // Gradient overlay — glassmorphism bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(19),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 18, 10, 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                              Colors.transparent,
                              const Color(0xFF424242).withValues(alpha: 0.7),
                              const Color(0xFF424242).withValues(alpha: 0.95),
                              const Color(0xFF424242),
                            ],
                      stops: const [0.0, 0.25, 0.5, 1.0],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nome prodotto
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : Colors.black87,
                          height: 1.2,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),

                      // Prezzi: Listino + Scontato
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            product.formattedBasePrice,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: isDark ? Colors.white30 : Colors.black26,
                              decoration: TextDecoration.lineThrough,
                              decorationColor:
                                  isDark ? Colors.white30 : Colors.black26,
                            ),
                          ),
                          if (product.hasPromo) ...[
                            const SizedBox(width: 4),
                            Text(
                              product.formattedPrice,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color:
                                    isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 1),

                      // Prezzo Elmetto — in evidenza
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB800)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.construction_rounded,
                              size: 11,
                              color: Color(0xFFFFB800),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${elmettoPrice.toStringAsFixed(2)} EUR',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFFFB800),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Tasti: Compra + Carrello
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                onBuyNow?.call();
                              },
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFB800),
                                      Color(0xFFFF9500),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFFB800)
                                          .withValues(alpha: 0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Compra',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              onAddToCart?.call();
                            },
                            child: Container(
                              height: 30,
                              width: 34,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF43A047),
                                    Color(0xFF2E7D32),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2E7D32)
                                        .withValues(alpha: 0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.shopping_cart_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Badge prodotto (top-right) — pill style
            if (product.badge.isVisible)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: product.badge.color,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: product.badge.color.withValues(alpha: 0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    product.badge.label,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

            // Sconto percentuale (top-left) — pill style
            if (product.hasPromo)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD32F2F)
                            .withValues(alpha: 0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '-${product.promoDiscountPercent}%',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }
}
