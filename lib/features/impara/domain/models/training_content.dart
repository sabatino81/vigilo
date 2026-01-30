import 'package:flutter/material.dart';

/// Tipo di contenuto formativo
enum ContentType {
  video,
  pdf,
  quiz,
  lesson;

  String get label {
    switch (this) {
      case ContentType.video:
        return 'Video';
      case ContentType.pdf:
        return 'PDF';
      case ContentType.quiz:
        return 'Quiz';
      case ContentType.lesson:
        return 'Lezione';
    }
  }

  IconData get icon {
    switch (this) {
      case ContentType.video:
        return Icons.play_circle_rounded;
      case ContentType.pdf:
        return Icons.picture_as_pdf_rounded;
      case ContentType.quiz:
        return Icons.quiz_rounded;
      case ContentType.lesson:
        return Icons.school_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ContentType.video:
        return const Color(0xFFE91E63);
      case ContentType.pdf:
        return const Color(0xFFFF5722);
      case ContentType.quiz:
        return const Color(0xFF9C27B0);
      case ContentType.lesson:
        return const Color(0xFF2196F3);
    }
  }
}

/// Categoria contenuto
enum ContentCategory {
  dpiSafety,
  firstAid,
  procedures,
  machinery,
  specificRisks,
  general;

  String get label {
    switch (this) {
      case ContentCategory.dpiSafety:
        return 'DPI e Sicurezza';
      case ContentCategory.firstAid:
        return 'Primo Soccorso';
      case ContentCategory.procedures:
        return 'Procedure Operative';
      case ContentCategory.machinery:
        return 'Macchinari';
      case ContentCategory.specificRisks:
        return 'Rischi Specifici';
      case ContentCategory.general:
        return 'Generale';
    }
  }

  IconData get icon {
    switch (this) {
      case ContentCategory.dpiSafety:
        return Icons.health_and_safety_rounded;
      case ContentCategory.firstAid:
        return Icons.medical_services_rounded;
      case ContentCategory.procedures:
        return Icons.list_alt_rounded;
      case ContentCategory.machinery:
        return Icons.precision_manufacturing_rounded;
      case ContentCategory.specificRisks:
        return Icons.warning_amber_rounded;
      case ContentCategory.general:
        return Icons.school_rounded;
    }
  }
}

/// Stato completamento contenuto
enum ContentStatus {
  notStarted,
  inProgress,
  completed;

  String get label {
    switch (this) {
      case ContentStatus.notStarted:
        return 'Non iniziato';
      case ContentStatus.inProgress:
        return 'In corso';
      case ContentStatus.completed:
        return 'Completato';
    }
  }

  Color get color {
    switch (this) {
      case ContentStatus.notStarted:
        return Colors.grey;
      case ContentStatus.inProgress:
        return const Color(0xFFFF9800);
      case ContentStatus.completed:
        return const Color(0xFF4CAF50);
    }
  }
}

/// Contenuto formativo (video, PDF, lezione)
class TrainingContent {
  const TrainingContent({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.durationMinutes,
    this.points = 0,
    this.status = ContentStatus.notStarted,
    this.progress = 0,
    this.thumbnailUrl,
    this.contentUrl,
    this.isMandatory = false,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String description;
  final ContentType type;
  final ContentCategory category;
  final int durationMinutes;
  final int points;
  final ContentStatus status;
  final double progress;
  final String? thumbnailUrl;
  final String? contentUrl;
  final bool isMandatory;
  final bool isFavorite;

  String get durationLabel {
    if (type == ContentType.pdf) {
      return '$durationMinutes pag';
    }
    return '$durationMinutes min';
  }

  TrainingContent copyWith({
    ContentStatus? status,
    double? progress,
    bool? isFavorite,
  }) {
    return TrainingContent(
      id: id,
      title: title,
      description: description,
      type: type,
      category: category,
      durationMinutes: durationMinutes,
      points: points,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      thumbnailUrl: thumbnailUrl,
      contentUrl: contentUrl,
      isMandatory: isMandatory,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Crea da JSON (risposta RPC get_training_contents).
  factory TrainingContent.fromJson(Map<String, dynamic> json) {
    return TrainingContent(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: _parseContentType(json['type'] as String?),
      category: _parseCategory(json['category'] as String?),
      durationMinutes: json['duration_minutes'] as int? ?? 0,
      points: json['points'] as int? ?? 0,
      status: _parseStatus(json['status'] as String?),
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      thumbnailUrl: json['thumbnail_url'] as String?,
      contentUrl: json['content_url'] as String?,
      isMandatory: json['is_mandatory'] as bool? ?? false,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  static ContentType _parseContentType(String? value) {
    if (value == null) return ContentType.lesson;
    return ContentType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ContentType.lesson,
    );
  }

  static ContentCategory _parseCategory(String? value) {
    if (value == null) return ContentCategory.general;
    return ContentCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ContentCategory.general,
    );
  }

  static ContentStatus _parseStatus(String? value) {
    if (value == null) return ContentStatus.notStarted;
    return ContentStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ContentStatus.notStarted,
    );
  }

  /// Mock data
  static List<TrainingContent> mockContents() {
    return const [
      TrainingContent(
        id: 'video_1',
        title: 'Uso sicuro dei DPI',
        description: 'Breve lezione sull\'uso corretto di casco, scarponi '
            'e giubbino ad alta visibilità sul lavoro.',
        type: ContentType.video,
        category: ContentCategory.dpiSafety,
        durationMinutes: 4,
        points: 10,
        isMandatory: true,
      ),
      TrainingContent(
        id: 'pdf_1',
        title: 'Manuale DPI Base',
        description: 'Guida completa all\'utilizzo dei dispositivi '
            'di protezione individuale.',
        type: ContentType.pdf,
        category: ContentCategory.dpiSafety,
        durationMinutes: 12,
        points: 5,
      ),
      TrainingContent(
        id: 'video_2',
        title: 'Scivolamenti: come evitarli',
        description: 'Micro-learning sulle cause più comuni di scivolamento '
            'e come prevenirle.',
        type: ContentType.lesson,
        category: ContentCategory.specificRisks,
        durationMinutes: 3,
        points: 10,
      ),
      TrainingContent(
        id: 'video_3',
        title: 'Primo soccorso base',
        description: 'Nozioni fondamentali di primo soccorso '
            'per interventi d\'emergenza.',
        type: ContentType.video,
        category: ContentCategory.firstAid,
        durationMinutes: 5,
        points: 15,
      ),
      TrainingContent(
        id: 'pdf_2',
        title: 'Procedure area chimica',
        description: 'Protocolli di sicurezza per operare '
            'in aree con rischio chimico.',
        type: ContentType.pdf,
        category: ContentCategory.procedures,
        durationMinutes: 8,
        points: 10,
      ),
      TrainingContent(
        id: 'video_4',
        title: 'Come usare una gru',
        description: 'Guida pratica all\'utilizzo sicuro '
            'della gru mobile in sicurezza.',
        type: ContentType.video,
        category: ContentCategory.machinery,
        durationMinutes: 6,
        points: 20,
        status: ContentStatus.inProgress,
        progress: 0.25,
      ),
      TrainingContent(
        id: 'video_5',
        title: 'Uso sicuro delle scale',
        description: 'Come utilizzare correttamente scale portatili '
            'e trabattelli.',
        type: ContentType.video,
        category: ContentCategory.dpiSafety,
        durationMinutes: 3,
        points: 10,
      ),
      TrainingContent(
        id: 'pdf_3',
        title: 'Kit primo soccorso: contenuto',
        description: 'Elenco completo del contenuto obbligatorio '
            'del kit di primo soccorso.',
        type: ContentType.pdf,
        category: ContentCategory.firstAid,
        durationMinutes: 4,
        points: 5,
      ),
      TrainingContent(
        id: 'video_6',
        title: '4 errori da evitare sul lavoro',
        description: 'Gli errori più comuni che causano infortuni '
            'e come evitarli.',
        type: ContentType.video,
        category: ContentCategory.general,
        durationMinutes: 4,
        points: 10,
      ),
      TrainingContent(
        id: 'lesson_1',
        title: 'Movimentazione carichi',
        description: 'Tecniche corrette per sollevare e trasportare '
            'carichi pesanti.',
        type: ContentType.lesson,
        category: ContentCategory.procedures,
        durationMinutes: 5,
        points: 15,
        status: ContentStatus.inProgress,
        progress: 0.4,
      ),
    ];
  }
}
