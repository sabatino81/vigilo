import 'package:flutter/material.dart';
import 'package:vigilo/features/sos/domain/models/report_status.dart';

/// Badge che mostra lo stato di una segnalazione
class ReportStatusBadge extends StatelessWidget {
  const ReportStatusBadge({
    required this.status,
    super.key,
    this.compact = false,
  });

  final ReportStatus status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!compact) ...[
            Icon(
              status.icon,
              color: status.color,
              size: 14,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            status.label.toUpperCase(),
            style: TextStyle(
              color: status.color,
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
