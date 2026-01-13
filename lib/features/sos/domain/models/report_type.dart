import 'package:flutter/material.dart';

/// Tipologie di segnalazione rapida
enum ReportType {
  imminentDanger,
  nearMiss,
  minorInjury,
  improvement;

  String get label {
    switch (this) {
      case ReportType.imminentDanger:
        return 'Pericolo';
      case ReportType.nearMiss:
        return 'Quasi incidente';
      case ReportType.minorInjury:
        return 'Piccolo infortunio';
      case ReportType.improvement:
        return 'Idea o consiglio';
    }
  }

  String get labelEn {
    switch (this) {
      case ReportType.imminentDanger:
        return 'Imminent Danger';
      case ReportType.nearMiss:
        return 'Near Miss';
      case ReportType.minorInjury:
        return 'Minor Injury';
      case ReportType.improvement:
        return 'Improvement';
    }
  }

  String get description {
    switch (this) {
      case ReportType.imminentDanger:
        return 'Qualcosa di pericoloso da sistemare subito';
      case ReportType.nearMiss:
        return 'Stavi per farti male, ma non è successo';
      case ReportType.minorInjury:
        return 'Ti sei fatto male ma niente di grave';
      case ReportType.improvement:
        return "Hai un'idea per migliorare la sicurezza";
    }
  }

  String get descriptionEn {
    switch (this) {
      case ReportType.imminentDanger:
        return 'Unstable material, obstacle, fall risk...';
      case ReportType.nearMiss:
        return 'Near accident, avoided risk';
      case ReportType.minorInjury:
        return 'Slips, bumps, small cuts...';
      case ReportType.improvement:
        return 'Something to fix or optimize';
    }
  }

  IconData get icon {
    switch (this) {
      case ReportType.imminentDanger:
        return Icons.warning_amber_rounded;
      case ReportType.nearMiss:
        return Icons.flash_on_rounded;
      case ReportType.minorInjury:
        return Icons.healing_rounded;
      case ReportType.improvement:
        return Icons.lightbulb_outline_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ReportType.imminentDanger:
        return const Color(0xFFD32F2F); // Rosso
      case ReportType.nearMiss:
        return const Color(0xFFFF6D00); // Arancione
      case ReportType.minorInjury:
        return const Color(0xFF1565C0); // Blu
      case ReportType.improvement:
        return const Color(0xFF2E7D32); // Verde
    }
  }

  Color get backgroundColor {
    switch (this) {
      case ReportType.imminentDanger:
        return const Color(0xFFFFCDD2);
      case ReportType.nearMiss:
        return const Color(0xFFFFE0B2);
      case ReportType.minorInjury:
        return const Color(0xFFBBDEFB);
      case ReportType.improvement:
        return const Color(0xFFC8E6C9);
    }
  }
}
