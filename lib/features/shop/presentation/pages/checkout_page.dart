import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/elmetto_wallet.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';
import 'package:vigilo/features/shop/presentation/widgets/price_breakdown_widget.dart';

/// Pagina checkout con conferma ordine
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    required this.items,
    required this.breakdown,
    required this.shippingEur,
    super.key,
  });

  final List<CartItem> items;
  final CheckoutBreakdown breakdown;
  final double shippingEur;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _useBnpl = false;

  double get _grandTotal =>
      widget.breakdown.workerPaysEur + widget.shippingEur;

  void _confirmOrder() {
    HapticFeedback.heavyImpact();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        icon: const Icon(
          Icons.check_circle_rounded,
          color: AppTheme.secondary,
          size: 48,
        ),
        title: const Text(
          'Ordine confermato!',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        content: Text(
          widget.breakdown.isFullyFree
              ? 'Il tuo ordine e stato confermato. '
                  'Coperto interamente dal welfare!'
              : _useBnpl
                  ? 'Pagherai in 3 rate da '
                      '${(_grandTotal / 3).toStringAsFixed(2)} EUR/mese '
                      'con Scalapay.'
                  : 'Totale addebitato: '
                      '${_grandTotal.toStringAsFixed(2)} EUR',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // Pop back to the punti page
              Navigator.of(context)
                ..pop() // checkout
                ..pop(); // cart (if came from cart)
            },
            child: const Text('Torna allo Shop'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Riepilogo articoli
            Text(
              'Articoli (${widget.items.length})',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ...widget.items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      item.product.emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${item.product.name} x${item.quantity}',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      ),
                    ),
                    Text(
                      item.formattedSubtotal,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 24),

            // Indirizzo mock
            Text(
              'Indirizzo di consegna',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 20,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Marco Rossi\n'
                      'Via della Sicurezza 42\n'
                      '20100 Milano (MI)',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? Colors.white70
                            : Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Breakdown pagamento
            PriceBreakdownWidget(
              breakdown: widget.breakdown,
              showBnpl: false,
            ),
            const SizedBox(height: 8),

            // Spedizione
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
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Spedizione',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? Colors.white54
                            : Colors.black45,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.shippingEur.toStringAsFixed(2)} EUR',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // BNPL toggle
            if (widget.breakdown.isBnplAvailable) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.tertiary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.credit_card_rounded,
                      color: AppTheme.tertiary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paga in 3 rate con Scalapay',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.tertiary,
                            ),
                          ),
                          Text(
                            '${(_grandTotal / 3).toStringAsFixed(2)}'
                            ' EUR/mese - interessi a carico tuo',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? Colors.white54
                                  : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _useBnpl,
                      onChanged: (v) => setState(() => _useBnpl = v),
                      activeColor: AppTheme.tertiary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Totale finale
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.primary.withValues(alpha: 0.1)
                    : AppTheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppTheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'TOTALE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.breakdown.isFullyFree
                        ? 'GRATIS'
                        : '${_grandTotal.toStringAsFixed(2)} EUR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: widget.breakdown.isFullyFree
                          ? AppTheme.secondary
                          : (isDark ? Colors.white : Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Conferma
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _confirmOrder,
                icon: Icon(
                  widget.breakdown.isFullyFree
                      ? Icons.check_circle_rounded
                      : Icons.lock_rounded,
                ),
                label: Text(
                  widget.breakdown.isFullyFree
                      ? 'Conferma ordine gratuito'
                      : 'Conferma e paga',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: widget.breakdown.isFullyFree
                      ? AppTheme.teal
                      : null,
                  foregroundColor: widget.breakdown.isFullyFree
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
