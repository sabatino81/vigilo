import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/shop/domain/models/voucher.dart';

/// Display di un voucher digitale con codice e placeholder QR
class VoucherDisplay extends StatelessWidget {
  const VoucherDisplay({required this.voucher, super.key});

  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.teal.withValues(alpha: 0.1)
            : AppTheme.teal.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.teal.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.card_giftcard_rounded,
                color: AppTheme.teal,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  voucher.productName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Text(
                voucher.formattedValue,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.teal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // QR Placeholder
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: isDark ? Colors.white : Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.qr_code_2_rounded,
                size: 80,
                color: isDark ? Colors.black87 : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Code
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: voucher.code));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Codice copiato!'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    voucher.code,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      letterSpacing: 1.5,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.copy_rounded,
                    size: 16,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Status
          if (voucher.isUsed)
            Text(
              'Utilizzato',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.danger,
              ),
            )
          else if (voucher.isExpired)
            Text(
              'Scaduto',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.danger,
              ),
            )
          else
            Text(
              'Valido fino al '
              '${_formatDate(voucher.expiresAt)}',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }
}
