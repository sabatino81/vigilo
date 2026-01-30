/// Domanda VOW (Voice of Worker)
class VowQuestion {
  const VowQuestion({
    required this.id,
    required this.text,
    required this.textEn,
  });

  final String id;
  final String text;
  final String textEn;

  static List<VowQuestion> mockQuestions() {
    return const [
      VowQuestion(
        id: 'vow_1',
        text: 'Ti sei sentito al sicuro oggi sul luogo di lavoro?',
        textEn: 'Did you feel safe at work today?',
      ),
      VowQuestion(
        id: 'vow_2',
        text: 'I DPI forniti sono adeguati e comodi?',
        textEn: 'Are the provided PPE adequate and comfortable?',
      ),
      VowQuestion(
        id: 'vow_3',
        text: 'La comunicazione sulla sicurezza è chiara?',
        textEn: 'Is safety communication clear?',
      ),
      VowQuestion(
        id: 'vow_4',
        text: 'Hai avuto difficoltà a segnalare un rischio?',
        textEn: 'Did you have difficulty reporting a risk?',
      ),
      VowQuestion(
        id: 'vow_5',
        text: 'Il tuo benessere psicofisico è tutelato?',
        textEn: 'Is your physical and mental wellbeing protected?',
      ),
    ];
  }
}

/// Risposta a una domanda VOW (scala 1-5)
class VowAnswer {
  const VowAnswer({
    required this.questionId,
    required this.rating,
  });

  final String questionId;

  /// Rating da 1 (per niente) a 5 (assolutamente sì)
  final int rating;

  VowAnswer copyWith({int? rating}) {
    return VowAnswer(
      questionId: questionId,
      rating: rating ?? this.rating,
    );
  }
}

/// Survey VOW completo
class VowSurvey {
  const VowSurvey({
    required this.id,
    required this.questions,
    required this.answers,
    this.isSubmitted = false,
  });

  final String id;
  final List<VowQuestion> questions;
  final Map<String, VowAnswer> answers;
  final bool isSubmitted;

  int get answeredCount => answers.length;
  int get totalQuestions => questions.length;
  bool get isComplete => answeredCount == totalQuestions;
  double get averageRating {
    if (answers.isEmpty) return 0;
    final sum = answers.values.fold<int>(
      0,
      (acc, a) => acc + a.rating,
    );
    return sum / answers.length;
  }

  /// Label rating scala 1-5
  static String ratingLabel(int rating) {
    switch (rating) {
      case 1:
        return 'Per niente';
      case 2:
        return 'Poco';
      case 3:
        return 'Abbastanza';
      case 4:
        return 'Molto';
      case 5:
        return 'Assolutamente';
      default:
        return '';
    }
  }

  static String ratingLabelEn(int rating) {
    switch (rating) {
      case 1:
        return 'Not at all';
      case 2:
        return 'A little';
      case 3:
        return 'Somewhat';
      case 4:
        return 'Very much';
      case 5:
        return 'Absolutely';
      default:
        return '';
    }
  }

  static const ratingEmojis = ['😞', '😕', '😐', '🙂', '😁'];
}
