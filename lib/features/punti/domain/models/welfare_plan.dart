import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Livello del piano welfare aziendale
enum WelfarePlanTier {
  small,
  medium,
  large;

  String get label {
    switch (this) {
      case WelfarePlanTier.small:
        return 'Piano S';
      case WelfarePlanTier.medium:
        return 'Piano M';
      case WelfarePlanTier.large:
        return 'Piano L';
    }
  }

  String get labelEn {
    switch (this) {
      case WelfarePlanTier.small:
        return 'Plan S';
      case WelfarePlanTier.medium:
        return 'Plan M';
      case WelfarePlanTier.large:
        return 'Plan L';
    }
  }

  double get monthlyBudgetEur {
    switch (this) {
      case WelfarePlanTier.small:
        return 80;
      case WelfarePlanTier.medium:
        return 150;
      case WelfarePlanTier.large:
        return 300;
    }
  }

  Color get color => AppTheme.teal;

  IconData get icon {
    switch (this) {
      case WelfarePlanTier.small:
        return Icons.star_border_rounded;
      case WelfarePlanTier.medium:
        return Icons.star_half_rounded;
      case WelfarePlanTier.large:
        return Icons.star_rounded;
    }
  }
}

/// Piano welfare aziendale del lavoratore
class WelfarePlan {
  const WelfarePlan({
    required this.tier,
    required this.monthlyBudgetEur,
    required this.usedEur,
    required this.companyName,
  });

  final WelfarePlanTier tier;
  final double monthlyBudgetEur;
  final double usedEur;
  final String companyName;

  double get remainingEur => monthlyBudgetEur - usedEur;

  double get usagePercent =>
      monthlyBudgetEur > 0 ? usedEur / monthlyBudgetEur : 0;

  bool get isExhausted => remainingEur <= 0;

  String get formattedRemaining => '${remainingEur.toStringAsFixed(2)} EUR';

  String get formattedBudget => '${monthlyBudgetEur.toStringAsFixed(0)} EUR';

  /// Mock data: Piano M con budget parzialmente usato
  static WelfarePlan mockPlan() {
    return const WelfarePlan(
      tier: WelfarePlanTier.medium,
      monthlyBudgetEur: 150,
      usedEur: 47,
      companyName: 'Costruzioni Rossi S.r.l.',
    );
  }
}
