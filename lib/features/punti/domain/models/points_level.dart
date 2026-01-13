import 'package:flutter/material.dart';

/// Livelli utente nel sistema punti
enum PointsLevel {
  bronze,
  silver,
  gold,
  platinum,
  diamond;

  String get label {
    switch (this) {
      case PointsLevel.bronze:
        return 'Bronzo';
      case PointsLevel.silver:
        return 'Argento';
      case PointsLevel.gold:
        return 'Oro';
      case PointsLevel.platinum:
        return 'Platino';
      case PointsLevel.diamond:
        return 'Diamante';
    }
  }

  String get labelEn {
    switch (this) {
      case PointsLevel.bronze:
        return 'Bronze';
      case PointsLevel.silver:
        return 'Silver';
      case PointsLevel.gold:
        return 'Gold';
      case PointsLevel.platinum:
        return 'Platinum';
      case PointsLevel.diamond:
        return 'Diamond';
    }
  }

  Color get color {
    switch (this) {
      case PointsLevel.bronze:
        return const Color(0xFFCD7F32);
      case PointsLevel.silver:
        return const Color(0xFFC0C0C0);
      case PointsLevel.gold:
        return const Color(0xFFFFD700);
      case PointsLevel.platinum:
        return const Color(0xFFE5E4E2);
      case PointsLevel.diamond:
        return const Color(0xFFB9F2FF);
    }
  }

  IconData get icon {
    switch (this) {
      case PointsLevel.bronze:
        return Icons.workspace_premium_rounded;
      case PointsLevel.silver:
        return Icons.workspace_premium_rounded;
      case PointsLevel.gold:
        return Icons.workspace_premium_rounded;
      case PointsLevel.platinum:
        return Icons.diamond_rounded;
      case PointsLevel.diamond:
        return Icons.diamond_rounded;
    }
  }

  /// Punti minimi per raggiungere questo livello
  int get minPoints {
    switch (this) {
      case PointsLevel.bronze:
        return 0;
      case PointsLevel.silver:
        return 500;
      case PointsLevel.gold:
        return 1500;
      case PointsLevel.platinum:
        return 3000;
      case PointsLevel.diamond:
        return 5000;
    }
  }

  /// Punti necessari per il prossimo livello
  int get maxPoints {
    switch (this) {
      case PointsLevel.bronze:
        return 500;
      case PointsLevel.silver:
        return 1500;
      case PointsLevel.gold:
        return 3000;
      case PointsLevel.platinum:
        return 5000;
      case PointsLevel.diamond:
        return 10000;
    }
  }

  /// Prossimo livello
  PointsLevel? get nextLevel {
    switch (this) {
      case PointsLevel.bronze:
        return PointsLevel.silver;
      case PointsLevel.silver:
        return PointsLevel.gold;
      case PointsLevel.gold:
        return PointsLevel.platinum;
      case PointsLevel.platinum:
        return PointsLevel.diamond;
      case PointsLevel.diamond:
        return null;
    }
  }

  /// Calcola il livello in base ai punti totali
  static PointsLevel fromPoints(int points) {
    if (points >= 5000) return PointsLevel.diamond;
    if (points >= 3000) return PointsLevel.platinum;
    if (points >= 1500) return PointsLevel.gold;
    if (points >= 500) return PointsLevel.silver;
    return PointsLevel.bronze;
  }

  /// Calcola la percentuale di progresso verso il prossimo livello
  static double progressToNextLevel(int points) {
    final currentLevel = fromPoints(points);
    if (currentLevel == PointsLevel.diamond) return 1.0;

    final min = currentLevel.minPoints;
    final max = currentLevel.maxPoints;
    return (points - min) / (max - min);
  }
}
