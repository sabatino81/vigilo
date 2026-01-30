/// Contributo individuale a una sfida
class ChallengeContribution {
  const ChallengeContribution({
    required this.name,
    required this.points,
  });

  final String name;
  final int points;

  /// Crea da JSON (risposta RPC get_active_challenge → contributions[]).
  factory ChallengeContribution.fromJson(Map<String, dynamic> json) {
    return ChallengeContribution(
      name: json['name'] as String? ?? '',
      points: json['points'] as int? ?? 0,
    );
  }
}

/// Sfida team
class Challenge {
  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.targetPoints,
    required this.currentPoints,
    required this.bonusPoints,
    required this.deadline,
    required this.contributions,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final int targetPoints;
  final int currentPoints;
  final int bonusPoints;
  final DateTime deadline;
  final List<ChallengeContribution> contributions;
  final bool isCompleted;

  double get progress =>
      targetPoints > 0 ? currentPoints / targetPoints : 0;

  int get progressPercent => (progress * 100).round().clamp(0, 100);

  int get remainingPoints => (targetPoints - currentPoints).clamp(0, targetPoints);

  Duration get timeRemaining => deadline.difference(DateTime.now());

  String get timeRemainingLabel {
    final d = timeRemaining;
    if (d.isNegative) return 'Scaduta';
    if (d.inDays > 0) return '${d.inDays}g rimanenti';
    if (d.inHours > 0) return '${d.inHours}h rimanenti';
    return '${d.inMinutes}min rimanenti';
  }

  /// Crea da JSON (risposta RPC get_active_challenge / get_challenge_history).
  factory Challenge.fromJson(Map<String, dynamic> json) {
    final rawContributions = json['contributions'] as List<dynamic>? ?? [];
    return Challenge(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      targetPoints: json['target_points'] as int? ?? 0,
      currentPoints: json['current_points'] as int? ?? 0,
      bonusPoints: json['bonus_points'] as int? ?? 0,
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : DateTime.now(),
      contributions: rawContributions
          .whereType<Map<String, dynamic>>()
          .map(ChallengeContribution.fromJson)
          .toList(),
      isCompleted: json['is_completed'] as bool? ?? false,
    );
  }

  /// Mock sfida attiva
  static Challenge mockChallenge() {
    return Challenge(
      id: 'ch_1',
      title: 'Zero Incidenti',
      description: 'Raggiungi 5000 punti sicurezza come team '
          'senza nessun incidente registrato. '
          'Ogni membro contribuisce con le proprie azioni quotidiane.',
      targetPoints: 5000,
      currentPoints: 3420,
      bonusPoints: 200,
      deadline: DateTime.now().add(const Duration(days: 5)),
      contributions: const [
        ChallengeContribution(name: 'Marco R.', points: 890),
        ChallengeContribution(name: 'Ahmed K.', points: 720),
        ChallengeContribution(name: 'Luca B.', points: 650),
        ChallengeContribution(name: 'Paolo M.', points: 580),
        ChallengeContribution(name: 'Roberto C.', points: 380),
        ChallengeContribution(name: 'Andrea S.', points: 200),
      ],
    );
  }

  /// Storico sfide completate
  static List<Challenge> mockHistory() {
    final now = DateTime.now();
    return [
      Challenge(
        id: 'ch_h1',
        title: 'Tutti con il Casco',
        description: 'Check-in DPI completati da tutto il team.',
        targetPoints: 3000,
        currentPoints: 3000,
        bonusPoints: 150,
        deadline: now.subtract(const Duration(days: 10)),
        contributions: const [],
        isCompleted: true,
      ),
      Challenge(
        id: 'ch_h2',
        title: 'Formazione Sprint',
        description: '10 quiz completati dal team.',
        targetPoints: 2000,
        currentPoints: 2200,
        bonusPoints: 100,
        deadline: now.subtract(const Duration(days: 25)),
        contributions: const [],
        isCompleted: true,
      ),
    ];
  }
}
