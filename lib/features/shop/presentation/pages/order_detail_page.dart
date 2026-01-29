import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/shop/domain/models/order.dart';
import 'package:vigilo/features/shop/domain/models/voucher.dart';
import 'package:vigilo/features/shop/presentation/widgets/order_status_badge.dart';
import 'package:vigilo/features/shop/presentation/widgets/tracking_timeline.dart';
import 'package:vigilo/features/shop/presentation/widgets/voucher_display.dart';

/// Pagina dettaglio ordine con tracking e voucher
class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Check if any items are vouchers (mock)
    final hasVoucher = order.items.any(
      (i) => i.product.category.name == 'voucher',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          order.orderCode,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status
            Center(child: OrderStatusBadge(status: order.status)),
            const SizedBox(height: 20),

            // Items
            Text(
              'Articoli',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      item.product.emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          Text(
                            'x${item.quantity}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? Colors.white54
                                  : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      item.formattedSubtotal,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? Colors.white70
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 24),

            // Payment breakdown
            _PaymentSection(order: order, isDark: isDark),
            const SizedBox(height: 20),

            // Tracking
            if (order.status != OrderStatus.cancelled) ...[
              Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              if (order.trackingCode != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_shipping_rounded,
                        size: 16,
                        color: isDark
                            ? Colors.white54
                            : Colors.black45,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order.trackingCode!,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          color: isDark
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              TrackingTimeline(currentStatus: order.status),
            ],

            // Voucher section (mock)
            if (hasVoucher) ...[
              const SizedBox(height: 16),
              Text(
                'Voucher',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              VoucherDisplay(
                voucher: Voucher.mockVouchers().first,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PaymentSection extends StatelessWidget {
  const _PaymentSection({
    required this.order,
    required this.isDark,
  });

  final Order order;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _Line(
            label: 'Subtotale',
            value: '${order.totalEur.toStringAsFixed(2)} EUR',
            isDark: isDark,
          ),
          if (order.welfareUsedEur > 0)
            _Line(
              label: 'Welfare',
              value:
                  '-${order.welfareUsedEur.toStringAsFixed(2)} EUR',
              valueColor: AppTheme.teal,
              isDark: isDark,
            ),
          if (order.elmettoDiscountEur > 0)
            _Line(
              label: 'Sconto Elmetto',
              value:
                  '-${order.elmettoDiscountEur.toStringAsFixed(2)} '
                  'EUR',
              valueColor: AppTheme.ambra,
              isDark: isDark,
            ),
          if (order.shippingEur > 0)
            _Line(
              label: 'Spedizione',
              value: '${order.shippingEur.toStringAsFixed(2)} EUR',
              isDark: isDark,
            ),
          const Divider(height: 12),
          _Line(
            label: 'Totale pagato',
            value: order.finalPriceEur > 0
                ? '${(order.finalPriceEur + order.shippingEur).toStringAsFixed(2)} EUR'
                : 'GRATIS',
            isBold: true,
            isDark: isDark,
          ),
          if (order.usedBnpl)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.credit_card_rounded,
                    size: 14,
                    color: AppTheme.tertiary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Pagato con Scalapay (3 rate)',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.label,
    required this.value,
    required this.isDark,
    this.valueColor,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isBold ? 14 : 13,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 15 : 13,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
              color: valueColor ??
                  (isDark ? Colors.white : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
