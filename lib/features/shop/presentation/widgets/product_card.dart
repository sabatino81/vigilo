import 'package:flutter/material.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/product_badge.dart';

/// Card prodotto per la griglia catalogo
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.onTap,
    super.key,
  });

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emoji prodotto
                  Center(
                    child: Text(
                      product.emoji,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Nome
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Categoria
                  Row(
                    children: [
                      Icon(
                        product.category.icon,
                        size: 12,
                        color: product.category.color,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          product.category.label,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? Colors.white54
                                : Colors.black45,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Prezzo
                  if (product.hasPromo) ...[
                    Text(
                      product.formattedBasePrice,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white38 : Colors.black26,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    product.formattedPrice,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Badge overlay
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
          ],
        ),
      ),
    );
  }
}
