import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Livello streak
enum StreakLevel {
  fiammella,
  fuocherello,
  falo,
  incendio,
  inferno;

  String get label {
    switch (this) {
      case StreakLevel.fiammella:
        return 'Fiammella';
      case StreakLevel.fuocherello:
        return 'Fuocherello';
      case StreakLevel.falo:
        return 'Falo';
      case StreakLevel.incendio:
        return 'Incendio';
      case StreakLevel.inferno:
        return 'Inferno';
    }
  }

  String get labelEn {
    switch (this) {
      case StreakLevel.fiammella:
        return 'Spark';
      case StreakLevel.fuocherello:
        return 'Flame';
      case StreakLevel.falo:
        return 'Bonfire';
      case StreakLevel.incendio:
        return 'Blaze';
      case StreakLevel.inferno:
        return 'Inferno';
    }
  }

  String get emoji {
    switch (this) {
      case StreakLevel.fiammella:
        return '🕯️';
      case StreakLevel.fuocherello:
        return '🔥';
      case StreakLevel.falo:
        return '🔥';
      case StreakLevel.incendio:
        return '🌋';
      case StreakLevel.inferno:
        return '☄️';
    }
  }

  int get minDays {
    switch (this) {
      case StreakLevel.fiammella:
        return 1;
      case StreakLevel.fuocherello:
        return 7;
      case StreakLevel.falo:
        return 14;
      case StreakLevel.incendio:
        return 30;
      case StreakLevel.inferno:
        return 60;
    }
  }

  double get multiplier {
    switch (this) {
      case StreakLevel.fiammella:
        return 1.0;
      case StreakLevel.fuocherello:
        return 1.2;
      case StreakLevel.falo:
        return 1.5;
      case StreakLevel.incendio:
        return 2.0;
      case StreakLevel.inferno:
        return 3.0;
    }
  }

  Color get color {
    switch (this) {
      case StreakLevel.fiammella:
        return AppTheme.primary;
      case StreakLevel.fuocherello:
        return AppTheme.ambra;
      case StreakLevel.falo:
        return const Color(0xFFFF5722);
      case StreakLevel.incendio:
        return AppTheme.danger;
      case StreakLevel.inferno:
        return const Color(0xFF9C27B0);
    }
  }

  IconData get icon {
    switch (this) {
      case StreakLevel.fiammella:
        return Icons.local_fire_department_outlined;
      case StreakLevel.fuocherello:
        return Icons.local_fire_department_rounded;
      case StreakLevel.falo:
        return Icons.local_fire_department_rounded;
      case StreakLevel.incendio:
        return Icons.whatshot_rounded;
      case StreakLevel.inferno:
        return Icons.whatshot_rounded;
    }
  }

  static StreakLevel fromDays(int days) {
    if (days >= 60) return StreakLevel.inferno;
    if (days >= 30) return StreakLevel.incendio;
    if (days >= 14) return StreakLevel.falo;
    if (days >= 7) return StreakLevel.fuocherello;
    return StreakLevel.fiammella;
  }
}

/// Dati streak utente
class Streak {
  const Streak({
    required this.currentDays,
    required this.bestStreak,
    required this.calendarDays,
  });

  final int currentDays;
  final int bestStreak;

  /// Giorni attivi nel mese corrente (1-31)
  final List<int> calendarDays;

  StreakLevel get currentLevel => StreakLevel.fromDays(currentDays);

  double get multiplier => currentLevel.multiplier;

  StreakLevel? get nextLevel {
    final levels = StreakLevel.values;
    final idx = levels.indexOf(currentLevel);
    if (idx < levels.length - 1) return levels[idx + 1];
    return null;
  }

  int? get daysToNextLevel {
    final next = nextLevel;
    if (next == null) return null;
    return next.minDays - currentDays;
  }

  /// Mock data
  static Streak mockStreak() {
    final now = DateTime.now();
    // Simula 14 giorni di streak con alcune pause
    final activeDays = <int>[];
    for (var i = 1; i <= now.day; i++) {
      if (i >= now.day - 13) {
        activeDays.add(i);
      } else if (i % 3 != 0) {
        activeDays.add(i);
      }
    }

    return Streak(
      currentDays: 14,
      bestStreak: 28,
      calendarDays: activeDays,
    );
  }
}
