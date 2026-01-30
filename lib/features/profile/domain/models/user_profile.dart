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
    required this.id,
    required this.name,
    required this.email,
    required this.category,
    required this.trustLevel,
    required this.safetyScore,
    required this.streakDays,
    required this.reportsCount,
    required this.puntiElmetto,
    required this.welfareActive,
    required this.companyName,
    this.avatarUrl,
  });

  /// Crea un [UserProfile] da una mappa JSON (risposta RPC Supabase).
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      category: _parseCategory(json['category'] as String?),
      trustLevel: _parseTrustLevel(json['trust_level'] as String?),
      safetyScore: json['safety_score'] as int? ?? 0,
      streakDays: json['streak_days'] as int? ?? 0,
      reportsCount: json['reports_count'] as int? ?? 0,
      puntiElmetto: json['punti_elmetto'] as int? ?? 0,
      welfareActive: json['welfare_active'] as bool? ?? false,
      companyName: json['company_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  final String id;
  final String name;
  final String email;
  final WorkerCategory category;
  final TrustLevel trustLevel;
  final int safetyScore;
  final int streakDays;
  final int reportsCount;
  final int puntiElmetto;
  final bool welfareActive;
  final String companyName;
  final String? avatarUrl;

  /// Converte in mappa JSON per invio a Supabase.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'category': category.name,
      'trust_level': trustLevel.name,
      'safety_score': safetyScore,
      'streak_days': streakDays,
      'reports_count': reportsCount,
      'punti_elmetto': puntiElmetto,
      'welfare_active': welfareActive,
      'company_name': companyName,
      'avatar_url': avatarUrl,
    };
  }

  UserProfile copyWith({
    String? name,
    WorkerCategory? category,
    String? avatarUrl,
    int? puntiElmetto,
    int? safetyScore,
    int? streakDays,
    int? reportsCount,
    TrustLevel? trustLevel,
    bool? welfareActive,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email,
      category: category ?? this.category,
      trustLevel: trustLevel ?? this.trustLevel,
      safetyScore: safetyScore ?? this.safetyScore,
      streakDays: streakDays ?? this.streakDays,
      reportsCount: reportsCount ?? this.reportsCount,
      puntiElmetto: puntiElmetto ?? this.puntiElmetto,
      welfareActive: welfareActive ?? this.welfareActive,
      companyName: companyName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  static WorkerCategory _parseCategory(String? value) {
    if (value == null) return WorkerCategory.operaio;
    return WorkerCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => WorkerCategory.operaio,
    );
  }

  static TrustLevel _parseTrustLevel(String? value) {
    if (value == null) return TrustLevel.base;
    return TrustLevel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TrustLevel.base,
    );
  }

  /// Mock profile (fallback per dev/test offline)
  static UserProfile mockProfile() {
    return const UserProfile(
      id: 'mock-user-id',
      name: 'Marco Rossi',
      email: 'marco.rossi@costruzionirossi.it',
      category: WorkerCategory.operaio,
      trustLevel: TrustLevel.trusted,
      safetyScore: 87,
      streakDays: 14,
      reportsCount: 8,
      puntiElmetto: 1800,
      welfareActive: true,
      companyName: 'Costruzioni Rossi S.r.l.',
    );
  }
}
