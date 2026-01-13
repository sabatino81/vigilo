import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class TransparencyDashboardCard extends StatelessWidget {
  const TransparencyDashboardCard({super.key});

  // Static data
  static final List<Map<String, dynamic>> _requests = [
    {
      'title': 'Serve più luce nell\'area 3.',
      'status': 'in_progress',
      'progress': 0.6,
    },
    {
      'title': 'Guanti più resistenti.',
      'status': 'resolved',
      'progress': 1.0,
    },
    {
      'title': 'Migliorare rifornimento acqua.',
      'status': 'evaluating',
      'progress': 0.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
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
                  Icons.fact_check_rounded,
                  color: AppTheme.tertiary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n?.transparencyTitle ?? '"AVETE DETTO → ABBIAMO FATTO"',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Requests list
          ...List.generate(_requests.length, (index) {
            final request = _requests[index];
            return _buildRequestItem(
              request['title'] as String,
              request['status'] as String,
              request['progress'] as double,
              isDark,
              l10n,
            );
          }),

          const SizedBox(height: 12),

          // Action button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
              },
              icon: const Icon(Icons.list_alt_rounded, size: 20),
              label: Text(l10n?.viewAllRequests ?? 'Vedi tutte le richieste'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.tertiary,
                side: BorderSide(
                  color: AppTheme.tertiary.withValues(alpha: 0.5),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestItem(
    String title,
    String status,
    double progress,
    bool isDark,
    AppLocalizations? l10n,
  ) {
    final statusInfo = _getStatusInfo(status, l10n);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Request title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.format_quote_rounded,
                color: AppTheme.neutral.withValues(alpha: 0.5),
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Status and progress
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusInfo.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusInfo.label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusInfo.color,
                  ),
                ),
              ),
              if (status == 'in_progress') ...[
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.black.withValues(alpha: 0.08),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        statusInfo.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: statusInfo.color,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  ({String label, Color color}) _getStatusInfo(
      String status, AppLocalizations? l10n) {
    return switch (status) {
      'resolved' => (
          label: l10n?.statusResolved ?? 'RISOLTO',
          color: AppTheme.secondary
        ),
      'in_progress' => (
          label: l10n?.statusInProgress ?? 'IN CORSO',
          color: AppTheme.tertiary
        ),
      'evaluating' => (
          label: l10n?.statusEvaluating ?? 'IN VALUTAZIONE',
          color: AppTheme.warning
        ),
      _ => (label: l10n?.statusNew ?? 'NUOVO', color: AppTheme.neutral),
    };
  }
}
