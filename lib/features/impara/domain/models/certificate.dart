/// Certificato formativo
class Certificate {
  const Certificate({
    required this.id,
    required this.title,
    required this.description,
    required this.earnedAt,
    this.expiresAt,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final DateTime earnedAt;
  final DateTime? expiresAt;
  final String? imageUrl;

  bool get isExpired =>
      expiresAt != null && expiresAt!.isBefore(DateTime.now());

  bool get isExpiringSoon {
    if (expiresAt == null) return false;
    final daysUntilExpiry = expiresAt!.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 30 && daysUntilExpiry > 0;
  }

  /// Crea da JSON (risposta RPC get_my_training_progress → certificates[]).
  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      earnedAt: json['earned_at'] != null
          ? DateTime.parse(json['earned_at'] as String)
          : DateTime.now(),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : null,
      imageUrl: json['image_url'] as String?,
    );
  }

  /// Mock data
  static List<Certificate> mockCertificates() {
    return [
      Certificate(
        id: 'cert_1',
        title: 'Attestato DPI Base',
        description:
            'Formazione sull\'uso dei dispositivi '
            'di protezione individuale',
        earnedAt: DateTime.now().subtract(const Duration(days: 45)),
        expiresAt: DateTime.now().add(const Duration(days: 320)),
      ),
      Certificate(
        id: 'cert_2',
        title: 'Formazione Generale Sicurezza',
        description:
            'Formazione generale sulla sicurezza '
            'nei luoghi di lavoro (4 ore)',
        earnedAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
    ];
  }
}

/// Progresso formativo complessivo
class TrainingProgress {
  const TrainingProgress({
    required this.totalModules,
    required this.completedModules,
    required this.inProgressModules,
    required this.certificates,
  });

  final int totalModules;
  final int completedModules;
  final List<String> inProgressModules;
  final List<Certificate> certificates;

  double get progressPercentage =>
      totalModules > 0 ? completedModules / totalModules : 0;

  int get progressPercent => (progressPercentage * 100).round();

  /// Crea da JSON (risposta RPC get_my_training_progress).
  factory TrainingProgress.fromJson(Map<String, dynamic> json) {
    final rawCerts = json['certificates'] as List<dynamic>? ?? [];
    return TrainingProgress(
      totalModules: json['total_modules'] as int? ?? 0,
      completedModules: json['completed_modules'] as int? ?? 0,
      inProgressModules:
          (json['in_progress_modules'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      certificates: rawCerts
          .whereType<Map<String, dynamic>>()
          .map(Certificate.fromJson)
          .toList(),
    );
  }

  /// Mock data
  static TrainingProgress mockProgress() {
    return TrainingProgress(
      totalModules: 22,
      completedModules: 14,
      inProgressModules: [
        'Uso gru mobile (25%)',
        'Movimentazione carichi (40%)',
      ],
      certificates: Certificate.mockCertificates(),
    );
  }
}
