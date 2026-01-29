import 'package:flutter/material.dart';
import 'package:vigilo/features/shop/domain/models/order.dart';
import 'package:vigilo/features/shop/presentation/widgets/order_status_badge.dart';

/// Tile ordine per la lista ordini
class OrderTile extends StatelessWidget {
  const OrderTile({
    required this.order,
    required this.onTap,
    super.key,
  });

  final Order order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.orderCode,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                OrderStatusBadge(status: order.status),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ...order.items.take(3).map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          item.product.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                if (order.items.length > 3)
                  Text(
                    '+${order.items.length - 3}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                const Spacer(),
                Text(
                  order.finalPriceEur > 0
                      ? '${order.finalPriceEur.toStringAsFixed(2)} EUR'
                      : 'GRATIS',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${order.itemCount} articoli - '
              '${_formatDate(order.createdAt)}',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }
}
