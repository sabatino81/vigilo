import 'package:flutter/material.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/product_badge.dart';

/// Card prodotto per la griglia catalogo — design con immagine grande e overlay
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
    // Prezzo elmetto = displayPrice meno 20% sconto max
    final elmettoPrice = product.displayPrice * (1 - _maxElmettoDiscount);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Emoji come immagine — occupa tutta la card
            Positioned.fill(
              child: Container(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.03)
                    : product.category.color.withValues(alpha: 0.06),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  product.emoji,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),

            // Gradient overlay in basso
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? [
                            Colors.transparent,
                            const Color(0xFF1A1A1A).withValues(alpha: 0.85),
                            const Color(0xFF1A1A1A),
                          ]
                        : [
                            Colors.transparent,
                            Colors.white.withValues(alpha: 0.9),
                            Colors.white,
                          ],
                    stops: const [0.0, 0.35, 1.0],
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
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),

                    // Riga 1: Listino (barrato) + Scontato (se promo)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Prezzo listino — sempre barrato
                        Text(
                          product.formattedBasePrice,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white38 : Colors.black26,
                            decoration: TextDecoration.lineThrough,
                            decorationColor:
                                isDark ? Colors.white38 : Colors.black26,
                          ),
                        ),
                        if (product.hasPromo) ...[
                          const SizedBox(width: 5),
                          // Prezzo scontato
                          Text(
                            product.formattedPrice,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 1),

                    // Riga 2: Prezzo Elmetto — in evidenza
                    Row(
                      children: [
                        Icon(
                          Icons.construction_rounded,
                          size: 13,
                          color: isDark
                              ? const Color(0xFFFFB800)
                              : const Color(0xFFE6A600),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${elmettoPrice.toStringAsFixed(2)} EUR',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: isDark
                                ? const Color(0xFFFFB800)
                                : const Color(0xFFE6A600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Tasti: Compra subito + Carrello
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: onBuyNow,
                            child: Container(
                              height: 28,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFB800),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Compra',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            height: 28,
                            width: 34,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 15,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Badge overlay (top-right)
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
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    product.badge.label,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

            // Sconto percentuale (top-left)
            if (product.hasPromo)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD32F2F),
                    borderRadius: BorderRadius.circular(6),
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
    );
  }
}
