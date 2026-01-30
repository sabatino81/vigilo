import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/elmetto_wallet.dart';

/// Widget riutilizzabile per il breakdown prezzo con wallet unico
class PriceBreakdownWidget extends StatelessWidget {
  const PriceBreakdownWidget({
    required this.breakdown,
    this.showBnpl = true,
    super.key,
  });

  final CheckoutBreakdown breakdown;
  final bool showBnpl;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                size: 16,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
              const SizedBox(width: 8),
              Text(
                'Riepilogo pagamento',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Subtotale
          _PriceLine(
            label: 'Subtotale',
            value: '${breakdown.totalEur.toStringAsFixed(2)} EUR',
            isDark: isDark,
          ),

          // Sconto Punti Elmetto
          if (breakdown.elmettoDiscountEur > 0)
            _PriceLine(
              label: 'Sconto Elmetto '
                  '(${breakdown.elmettoPointsUsed} pt)',
              value:
                  '-${breakdown.elmettoDiscountEur.toStringAsFixed(2)}'
                  ' EUR',
              valueColor: AppTheme.ambra,
              icon: Icons.construction_rounded,
              iconColor: AppTheme.ambra,
              isDark: isDark,
            ),

          // Quota a carico azienda (welfare)
          if (breakdown.companyPaysEur > 0)
            _PriceLine(
              label: 'A carico azienda (welfare)',
              value:
                  '-${breakdown.companyPaysEur.toStringAsFixed(2)} EUR',
              valueColor: AppTheme.teal,
              icon: Icons.business_rounded,
              iconColor: AppTheme.teal,
              isDark: isDark,
            ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    isDark
                        ? Colors.white.withValues(alpha: 0.15)
                        : Colors.black.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Totale da pagare
          _PriceLine(
            label: breakdown.isFullyFree
                ? 'Totale'
                : 'Da pagare',
            value: breakdown.isFullyFree
                ? 'GRATIS'
                : '${breakdown.workerPaysEur.toStringAsFixed(2)} EUR',
            valueColor: breakdown.isFullyFree
                ? AppTheme.secondary
                : const Color(0xFFFFB800),
            isBold: true,
            isDark: isDark,
          ),

          // BNPL
          if (showBnpl && breakdown.isBnplAvailable) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: AppTheme.tertiary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppTheme.tertiary.withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.tertiary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.credit_card_rounded,
                      size: 16,
                      color: AppTheme.tertiary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paga in 3 rate con Scalapay',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.tertiary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${(breakdown.workerPaysEur / 3).toStringAsFixed(2)}'
                          ' EUR/mese',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PriceLine extends StatelessWidget {
  const _PriceLine({
    required this.label,
    required this.value,
    required this.isDark,
    this.valueColor,
    this.icon,
    this.iconColor,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;
  final IconData? icon;
  final Color? iconColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: iconColor?.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 13, color: iconColor),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isBold ? 15 : 13,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 18 : 13,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
              color: valueColor ??
                  (isDark ? Colors.white : Colors.black87),
              letterSpacing: isBold ? -0.3 : 0,
            ),
          ),
        ],
      ),
    );
  }
}
