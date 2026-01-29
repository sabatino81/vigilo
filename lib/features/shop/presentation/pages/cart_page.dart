import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/dual_wallet.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/presentation/pages/checkout_page.dart';
import 'package:vigilo/features/shop/presentation/widgets/price_breakdown_widget.dart';

/// Pagina carrello
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ElmettoWallet _wallet = ElmettoWallet.mockWallet();

  // Mock cart: 2 prodotti pre-caricati
  late final List<CartItem> _items;

  @override
  void initState() {
    super.initState();
    final products = Product.mockProducts();
    _items = [
      CartItem(product: products[5], quantity: 1),
      CartItem(product: products[9]),
    ];
  }

  double get _subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.subtotal);

  CheckoutBreakdown get _breakdown =>
      _wallet.calculateCheckout(_subtotal);

  void _updateQuantity(int index, int delta) {
    setState(() {
      final item = _items[index];
      final newQty = (item.quantity + delta).clamp(1, 10);
      _items[index] = item.copyWith(quantity: newQty);
    });
  }

  void _removeItem(int index) {
    HapticFeedback.lightImpact();
    setState(() => _items.removeAt(index));
  }

  void _goToCheckout() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => CheckoutPage(
          items: List.unmodifiable(_items),
          breakdown: _breakdown,
          shippingEur: 5.90,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrello (${_items.length})',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: isDark ? Colors.white24 : Colors.black12,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Il carrello e vuoto',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
              child: Column(
                children: [
                  // Items
                  ...List.generate(_items.length, (i) {
                    final item = _items[i];
                    return _CartItemTile(
                      item: item,
                      isDark: isDark,
                      onIncrement: () => _updateQuantity(i, 1),
                      onDecrement: () => _updateQuantity(i, -1),
                      onRemove: () => _removeItem(i),
                    );
                  }),
                  const SizedBox(height: 16),

                  // Breakdown
                  PriceBreakdownWidget(breakdown: _breakdown),
                  const SizedBox(height: 8),

                  // Shipping note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.03)
                          : Colors.black.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          size: 16,
                          color: isDark
                              ? Colors.white38
                              : Colors.black38,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Spedizione: 5,90 EUR '
                            '(sempre a carico del lavoratore)',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? Colors.white38
                                  : Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _goToCheckout,
                      icon: const Icon(Icons.payment_rounded),
                      label: const Text('Procedi al checkout'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
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

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    required this.item,
    required this.isDark,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final CartItem item;
  final bool isDark;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          // Emoji
          Text(item.product.emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.formattedSubtotal,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          // Quantity controls
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MiniButton(
                icon: Icons.remove,
                onTap: item.quantity > 1 ? onDecrement : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${item.quantity}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              _MiniButton(
                icon: Icons.add,
                onTap: item.quantity < 10 ? onIncrement : null,
              ),
            ],
          ),
          const SizedBox(width: 8),
          // Remove
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.delete_outline_rounded,
              size: 20,
              color: AppTheme.danger.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniButton extends StatelessWidget {
  const _MiniButton({
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
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: enabled
              ? (isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.05))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled
              ? (isDark ? Colors.white70 : Colors.black54)
              : (isDark ? Colors.white12 : Colors.black12),
        ),
      ),
    );
  }
}
