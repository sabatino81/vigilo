import 'package:flutter/material.dart';
import 'package:vigilo/features/sos/domain/models/safety_report.dart';
import 'package:vigilo/features/sos/presentation/widgets/report_history_tile.dart';

/// Sezione storico segnalazioni
class ReportHistorySection extends StatelessWidget {
  const ReportHistorySection({
    required this.reports,
    required this.onReportTap,
    required this.onViewAllTap,
    super.key,
    this.maxItems = 3,
  });

  final List<SafetyReport> reports;
  final void Function(SafetyReport report) onReportTap;
  final VoidCallback onViewAllTap;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final displayedReports = reports.take(maxItems).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: isDark ? Colors.white70 : Colors.black54,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'LE TUE SEGNALAZIONI',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (reports.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.inbox_rounded,
                    size: 48,
                    color: isDark ? Colors.white24 : Colors.black12,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Non hai ancora fatto segnalazioni',
                    style: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
        else ...[
          ...displayedReports.map((report) => ReportHistoryTile(
                report: report,
                onTap: () => onReportTap(report),
              )),
          if (reports.length > maxItems) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: onViewAllTap,
                icon: const Icon(Icons.list_rounded, size: 18),
                label: Text(
                  'Vedi tutto (${reports.length})',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }
}
