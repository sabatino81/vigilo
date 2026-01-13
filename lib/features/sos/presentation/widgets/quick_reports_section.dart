import 'package:flutter/material.dart';
import 'package:vigilo/features/sos/domain/models/report_type.dart';
import 'package:vigilo/features/sos/presentation/widgets/quick_report_card.dart';

/// Sezione con griglia delle segnalazioni rapide
class QuickReportsSection extends StatelessWidget {
  const QuickReportsSection({
    required this.onReportSelected,
    super.key,
  });

  final void Function(ReportType type) onReportSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
                  Icons.edit_note_rounded,
                  color: isDark ? Colors.white70 : Colors.black54,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'SEGNALA UN PROBLEMA',
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
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Hai visto qualcosa che non va? Faccelo sapere',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
          children: ReportType.values.map((type) {
            return QuickReportCard(
              reportType: type,
              onTap: () => onReportSelected(type),
            );
          }).toList(),
        ),
      ],
    );
  }
}
