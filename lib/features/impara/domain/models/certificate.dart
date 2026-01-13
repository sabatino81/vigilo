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
