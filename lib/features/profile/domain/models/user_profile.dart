import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Categoria lavoratore
enum WorkerCategory {
  operaio,
  caposquadra,
  preposto,
  rspp;

  String get label {
    switch (this) {
      case WorkerCategory.operaio:
        return 'Operaio';
      case WorkerCategory.caposquadra:
        return 'Caposquadra';
      case WorkerCategory.preposto:
        return 'Preposto';
      case WorkerCategory.rspp:
        return 'RSPP';
    }
  }

  String get labelEn {
    switch (this) {
      case WorkerCategory.operaio:
        return 'Worker';
      case WorkerCategory.caposquadra:
        return 'Team Lead';
      case WorkerCategory.preposto:
        return 'Supervisor';
      case WorkerCategory.rspp:
        return 'Safety Officer';
    }
  }

  IconData get icon {
    switch (this) {
      case WorkerCategory.operaio:
        return Icons.construction_rounded;
      case WorkerCategory.caposquadra:
        return Icons.engineering_rounded;
      case WorkerCategory.preposto:
        return Icons.supervisor_account_rounded;
      case WorkerCategory.rspp:
        return Icons.health_and_safety_rounded;
    }
  }
}

/// Livello di fiducia del lavoratore
enum TrustLevel {
  base,
  verified,
  trusted,
  expert;

  String get label {
    switch (this) {
      case TrustLevel.base:
        return 'Base';
      case TrustLevel.verified:
        return 'Verificato';
      case TrustLevel.trusted:
        return 'Affidabile';
      case TrustLevel.expert:
        return 'Esperto';
    }
  }

  String get labelEn {
    switch (this) {
      case TrustLevel.base:
        return 'Base';
      case TrustLevel.verified:
        return 'Verified';
      case TrustLevel.trusted:
        return 'Trusted';
      case TrustLevel.expert:
        return 'Expert';
    }
  }

  Color get color {
    switch (this) {
      case TrustLevel.base:
        return AppTheme.neutral;
      case TrustLevel.verified:
        return AppTheme.tertiary;
      case TrustLevel.trusted:
        return AppTheme.secondary;
      case TrustLevel.expert:
        return AppTheme.ambra;
    }
  }

  IconData get icon {
    switch (this) {
      case TrustLevel.base:
        return Icons.shield_outlined;
      case TrustLevel.verified:
        return Icons.verified_outlined;
      case TrustLevel.trusted:
        return Icons.verified_user_rounded;
      case TrustLevel.expert:
        return Icons.workspace_premium_rounded;
    }
  }

  int get stars {
    switch (this) {
      case TrustLevel.base:
        return 1;
      case TrustLevel.verified:
        return 2;
      case TrustLevel.trusted:
        return 3;
      case TrustLevel.expert:
        return 4;
    }
  }
}

/// Profilo utente
class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.category,
    required this.trustLevel,
    required this.safetyScore,
    required this.streakDays,
    required this.reportsCount,
    required this.puntiElmetto,
    required this.welfareBalanceEur,
    required this.companyName,
  });

  final String name;
  final String email;
  final WorkerCategory category;
  final TrustLevel trustLevel;
  final int safetyScore;
  final int streakDays;
  final int reportsCount;
  final int puntiElmetto;
  final double welfareBalanceEur;
  final String companyName;

  /// Mock profile
  static UserProfile mockProfile() {
    return const UserProfile(
      name: 'Marco Rossi',
      email: 'marco.rossi@costruzionirossi.it',
      category: WorkerCategory.operaio,
      trustLevel: TrustLevel.trusted,
      safetyScore: 87,
      streakDays: 14,
      reportsCount: 8,
      puntiElmetto: 1500,
      welfareBalanceEur: 103,
      companyName: 'Costruzioni Rossi S.r.l.',
    );
  }
}
