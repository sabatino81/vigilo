import 'package:flutter/material.dart';
import 'package:vigilo/features/shop/domain/models/order.dart';

/// Timeline verticale per tracking ordine
class TrackingTimeline extends StatelessWidget {
  const TrackingTimeline({
    required this.currentStatus,
    super.key,
  });

  final OrderStatus currentStatus;

  static const _steps = [
    OrderStatus.confirmed,
    OrderStatus.processing,
    OrderStatus.shipped,
    OrderStatus.delivered,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentIdx = currentStatus == OrderStatus.cancelled
        ? -1
        : _steps.indexOf(currentStatus);

    return Column(
      children: List.generate(_steps.length, (i) {
        final step = _steps[i];
        final isCompleted = i <= currentIdx;
        final isLast = i == _steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dot + Line
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? step.color
                          : isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.06),
                      border: Border.all(
                        color: isCompleted
                            ? step.color
                            : isDark
                                ? Colors.white.withValues(alpha: 0.2)
                                : Colors.black
                                    .withValues(alpha: 0.1),
                        width: 2,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(
                            Icons.check,
                            size: 10,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 40,
                      color: isCompleted && i < currentIdx
                          ? step.color.withValues(alpha: 0.3)
                          : isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.black
                                  .withValues(alpha: 0.04),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Label
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isCompleted
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isCompleted
                            ? (isDark ? Colors.white : Colors.black87)
                            : (isDark
                                ? Colors.white38
                                : Colors.black26),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Icon
            Icon(
              step.icon,
              size: 18,
              color: isCompleted
                  ? step.color
                  : isDark
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.black.withValues(alpha: 0.08),
            ),
          ],
        );
      }),
    );
  }
}
