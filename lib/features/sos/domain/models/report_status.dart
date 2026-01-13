import 'package:flutter/material.dart';

/// Stati possibili di una segnalazione
enum ReportStatus {
  pending,
  underReview,
  inProgress,
  approved,
  closed;

  String get label {
    switch (this) {
      case ReportStatus.pending:
        return 'In attesa';
      case ReportStatus.underReview:
        return 'In esame';
      case ReportStatus.inProgress:
        return 'Ci stiamo lavorando';
      case ReportStatus.approved:
        return 'Confermata';
      case ReportStatus.closed:
        return 'Risolto';
    }
  }

  String get labelEn {
    switch (this) {
      case ReportStatus.pending:
        return 'Pending';
      case ReportStatus.underReview:
        return 'Under Review';
      case ReportStatus.inProgress:
        return 'In Progress';
      case ReportStatus.approved:
        return 'Approved';
      case ReportStatus.closed:
        return 'Closed';
    }
  }

  Color get color {
    switch (this) {
      case ReportStatus.pending:
        return const Color(0xFF9E9E9E); // Grigio
      case ReportStatus.underReview:
        return const Color(0xFFFF6D00); // Arancione
      case ReportStatus.inProgress:
        return const Color(0xFF1565C0); // Blu
      case ReportStatus.approved:
        return const Color(0xFF2E7D32); // Verde
      case ReportStatus.closed:
        return const Color(0xFF616161); // Grigio scuro
    }
  }

  Color get backgroundColor {
    switch (this) {
      case ReportStatus.pending:
        return const Color(0xFFEEEEEE);
      case ReportStatus.underReview:
        return const Color(0xFFFFE0B2);
      case ReportStatus.inProgress:
        return const Color(0xFFBBDEFB);
      case ReportStatus.approved:
        return const Color(0xFFC8E6C9);
      case ReportStatus.closed:
        return const Color(0xFFE0E0E0);
    }
  }

  IconData get icon {
    switch (this) {
      case ReportStatus.pending:
        return Icons.schedule_rounded;
      case ReportStatus.underReview:
        return Icons.visibility_rounded;
      case ReportStatus.inProgress:
        return Icons.engineering_rounded;
      case ReportStatus.approved:
        return Icons.check_circle_rounded;
      case ReportStatus.closed:
        return Icons.archive_rounded;
    }
  }
}
