import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/dual_wallet.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/presentation/widgets/price_breakdown_widget.dart';

/// Pagina dettaglio prodotto con breakdown prezzo dual wallet
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  final DualWallet _wallet = DualWallet.mockWallet();

  double get _totalPrice => widget.product.displayPrice * _quantity;

  CheckoutBreakdown get _breakdown => _wallet.calculateCheckout(_totalPrice);

  void _addToCart() {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Aggiunto al carrello: ${widget.product.name}'
          ' x$_quantity',
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Vai al carrello',
          onPressed: () {
            // TODO(nav): navigate to cart
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.category.label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji hero
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    product.emoji,
                    style: const TextStyle(fontSize: 64),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Badge
            if (product.badge.isVisible)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: product.badge.color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  product.badge.label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            const SizedBox(height: 8),

            // Nome
            Text(
              product.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),

            // Fornitore
            if (product.supplierName != null)
              Text(
                'Fornitore: ${product.supplierName}',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
              ),
            const SizedBox(height: 12),

            // Descrizione
            Text(
              product.description,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            // Prezzo
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (product.hasPromo) ...[
                  Text(
                    product.formattedBasePrice,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white38 : Colors.black26,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  product.formattedPrice,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                if (product.hasPromo) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.danger.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '-${product.promoDiscountPercent}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.danger,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),

            // Selettore quantita
            Row(
              children: [
                Text(
                  'Quantita',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                const Spacer(),
                _QuantityButton(
                  icon: Icons.remove_rounded,
                  onTap: _quantity > 1
                      ? () => setState(() => _quantity--)
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '$_quantity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                _QuantityButton(
                  icon: Icons.add_rounded,
                  onTap: _quantity < 10
                      ? () => setState(() => _quantity++)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Breakdown prezzo
            PriceBreakdownWidget(breakdown: _breakdown),
            const SizedBox(height: 20),

            // Pulsante aggiungi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addToCart,
                icon: const Icon(Icons.shopping_cart_rounded),
                label: Text(
                  _breakdown.isFullyFree
                      ? 'Aggiungi gratis'
                      : 'Aggiungi al carrello',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: _breakdown.isFullyFree
                      ? AppTheme.teal
                      : null,
                  foregroundColor: _breakdown.isFullyFree
                      ? AppTheme.onTeal
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final enabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled
              ? (isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.05))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: enabled
                ? (isDark
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.1))
                : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.05)),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled
              ? (isDark ? Colors.white70 : Colors.black54)
              : (isDark ? Colors.white12 : Colors.black12),
        ),
      ),
    );
  }
}
