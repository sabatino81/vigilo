import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class DpiStatusCard extends StatelessWidget {
  const DpiStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final dpiItems = [
      {'name': l10n?.dpiHelmet ?? 'Casco', 'icon': Icons.construction_rounded, 'status': 'ok'},
      {
        'name': l10n?.dpiSafetyShoes ?? 'Scarpe\nantinfortunistiche',
        'icon': Icons.do_not_step_rounded,
        'status': 'battery_low',
      },
      {'name': l10n?.dpiGloves ?? 'Guanti', 'icon': Icons.back_hand_rounded, 'status': 'ok'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2A2A2A)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.black.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.security_rounded,
                  color: AppTheme.tertiary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.dpiStatus ?? 'STATO DPI',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // DPI items
          ...dpiItems.map((item) => _buildDpiItem(
                item['name'] as String,
                item['icon'] as IconData,
                item['status'] as String,
                isDark,
                l10n,
              )),
        ],
      ),
    );
  }

  Widget _buildDpiItem(
    String name,
    IconData icon,
    String status,
    bool isDark,
    AppLocalizations? l10n,
  ) {
    final isOk = status == 'ok';
    final statusColor = isOk ? AppTheme.secondary : AppTheme.warning;
    final statusText = isOk
        ? (l10n?.dpiStatusOk ?? 'OK')
        : (l10n?.dpiStatusBatteryLow ?? 'Batteria\nbassa');
    final statusIcon =
        isOk ? Icons.check_circle_rounded : Icons.warning_rounded;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.white70 : Colors.black54,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
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
