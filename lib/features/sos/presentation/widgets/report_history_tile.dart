import 'package:flutter/material.dart';
import 'package:vigilo/features/sos/domain/models/safety_report.dart';
import 'package:vigilo/features/sos/presentation/widgets/report_status_badge.dart';

/// Tile per una singola segnalazione nello storico
class ReportHistoryTile extends StatelessWidget {
  const ReportHistoryTile({
    required this.report,
    required this.onTap,
    super.key,
  });

  final SafetyReport report;
  final VoidCallback onTap;

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      // Oggi: mostra l'ora
      return '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Ieri';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}g fa';
    } else {
      return '${dateTime.day}/${dateTime.month}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            children: [
              // Icona tipo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: report.type.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  report.type.icon,
                  color: report.type.color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              // Contenuto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _formatTime(report.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white54 : Colors.black45,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            report.type.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      report.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status badge
              ReportStatusBadge(
                status: report.status,
                compact: true,
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                color: isDark ? Colors.white38 : Colors.black26,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
