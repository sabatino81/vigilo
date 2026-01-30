import 'package:flutter/material.dart';

/// Domanda quiz
class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });

  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? explanation;

  bool isCorrect(int selectedIndex) => selectedIndex == correctIndex;

  /// Crea da JSON (risposta RPC get_quizzes → questions[]).
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'];
    List<String> options;
    if (rawOptions is List) {
      options = rawOptions.map((e) => e.toString()).toList();
    } else {
      options = [];
    }
    return QuizQuestion(
      id: json['id'] as String,
      text: json['text'] as String? ?? '',
      options: options,
      correctIndex: json['correct_index'] as int? ?? 0,
      explanation: json['explanation'] as String?,
    );
  }
}

/// Quiz formativo
class Quiz {
  const Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.points,
    this.category,
    this.estimatedMinutes = 5,
    this.maxAttempts = 1,
    this.passingScore = 0.6,
  });

  final String id;
  final String title;
  final String description;
  final List<QuizQuestion> questions;
  final int points;
  final String? category;
  final int estimatedMinutes;
  final int maxAttempts;
  final double passingScore;

  int get questionCount => questions.length;

  /// Crea da JSON (risposta RPC get_quizzes).
  factory Quiz.fromJson(Map<String, dynamic> json) {
    final rawQuestions = json['questions'] as List<dynamic>? ?? [];
    return Quiz(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      questions: rawQuestions
          .whereType<Map<String, dynamic>>()
          .map(QuizQuestion.fromJson)
          .toList(),
      points: json['points'] as int? ?? 0,
      category: json['category'] as String?,
      estimatedMinutes: json['estimated_minutes'] as int? ?? 5,
      maxAttempts: json['max_attempts'] as int? ?? 1,
      passingScore: (json['passing_score'] as num?)?.toDouble() ?? 0.6,
    );
  }

  /// Mock data - Quiz settimanale
  static Quiz weeklyQuiz() {
    return const Quiz(
      id: 'quiz_weekly',
      title: 'Quiz Settimanale',
      description: 'Quiz sulla sicurezza base sul lavoro',
      points: 20,
      category: 'Sicurezza base sul lavoro',
      estimatedMinutes: 5,
      questions: [
        QuizQuestion(
          id: 'q1',
          text: 'In quale situazione è obbligatorio indossare il casco?',
          options: [
            'Sempre, in ogni area di lavoro',
            'Solo nelle aree con segnaletica "casco obbligatorio"',
            'Solo quando si lavora in altezza',
            'Solo quando lo dice il preposto',
          ],
          correctIndex: 0,
          explanation: 'Il casco è obbligatorio in tutte le aree di lavoro '
              'per proteggere da caduta di oggetti.',
        ),
        QuizQuestion(
          id: 'q2',
          text: 'Qual è la distanza minima di sicurezza da un\'area di scavo?',
          options: [
            '0.5 metri',
            '1 metro',
            '1.5 metri',
            '2 metri',
          ],
          correctIndex: 2,
          explanation: 'La distanza minima di sicurezza da uno scavo '
              'è di 1.5 metri per evitare cedimenti del terreno.',
        ),
        QuizQuestion(
          id: 'q3',
          text: 'Chi è responsabile della verifica quotidiana dei DPI?',
          options: [
            'Solo il datore di lavoro',
            'Solo il preposto',
            'Ogni lavoratore per i propri DPI',
            'Solo l\'RSPP',
          ],
          correctIndex: 2,
          explanation: 'Ogni lavoratore deve verificare lo stato dei propri DPI '
              'prima di iniziare il lavoro.',
        ),
        QuizQuestion(
          id: 'q4',
          text: 'Cosa fare in caso di sversamento di sostanze chimiche?',
          options: [
            'Pulire immediatamente con acqua',
            'Avvisare il preposto e seguire le procedure',
            'Continuare a lavorare se lo sversamento è piccolo',
            'Coprire con sabbia e proseguire',
          ],
          correctIndex: 1,
          explanation: 'In caso di sversamento, avvisare subito il preposto '
              'e seguire le procedure specifiche per la sostanza.',
        ),
        QuizQuestion(
          id: 'q5',
          text: 'Ogni quanto va verificata la scala portatile?',
          options: [
            'Una volta all\'anno',
            'Una volta al mese',
            'Prima di ogni utilizzo',
            'Solo se sembra danneggiata',
          ],
          correctIndex: 2,
          explanation: 'La scala va verificata prima di ogni utilizzo '
              'per garantire la sicurezza.',
        ),
        QuizQuestion(
          id: 'q6',
          text: 'Qual è il colore della segnaletica di divieto?',
          options: [
            'Giallo con bordo nero',
            'Rosso con simbolo nero',
            'Verde con simbolo bianco',
            'Blu con simbolo bianco',
          ],
          correctIndex: 1,
          explanation: 'I segnali di divieto hanno sfondo bianco, '
              'bordo e barra rossi, simbolo nero.',
        ),
        QuizQuestion(
          id: 'q7',
          text: 'Quando è necessario usare l\'imbracatura di sicurezza?',
          options: [
            'Solo sopra i 5 metri',
            'Sopra i 2 metri senza protezioni collettive',
            'Solo su ponteggi',
            'Solo all\'esterno degli edifici',
          ],
          correctIndex: 1,
          explanation: 'L\'imbracatura è obbligatoria sopra i 2 metri '
              'quando non ci sono protezioni collettive.',
        ),
        QuizQuestion(
          id: 'q8',
          text: 'Chi può operare un carrello elevatore?',
          options: [
            'Chiunque dopo una breve spiegazione',
            'Solo chi ha l\'abilitazione specifica',
            'Tutti i dipendenti con patente B',
            'Solo il magazziniere',
          ],
          correctIndex: 1,
          explanation: 'Il carrello elevatore richiede abilitazione specifica '
              'secondo il D.Lgs. 81/08.',
        ),
        QuizQuestion(
          id: 'q9',
          text: 'Cosa indica un segnale triangolare giallo?',
          options: [
            'Divieto',
            'Obbligo',
            'Pericolo/Avvertimento',
            'Informazione',
          ],
          correctIndex: 2,
          explanation: 'I segnali triangolari gialli con bordo nero '
              'indicano pericolo o avvertimento.',
        ),
        QuizQuestion(
          id: 'q10',
          text: 'Qual è la prima cosa da fare in caso di infortunio?',
          options: [
            'Chiamare l\'ambulanza',
            'Mettere in sicurezza l\'area',
            'Spostare l\'infortunato',
            'Avvisare il datore di lavoro',
          ],
          correctIndex: 1,
          explanation: 'La priorità è mettere in sicurezza l\'area '
              'per evitare ulteriori incidenti.',
        ),
      ],
    );
  }
}

/// Risultato quiz
class QuizResult {
  const QuizResult({
    required this.quizId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.answers,
    required this.completedAt,
    required this.earnedPoints,
  });

  final String quizId;
  final int totalQuestions;
  final int correctAnswers;
  final List<int> answers;
  final DateTime completedAt;
  final int earnedPoints;

  /// Crea da JSON (risposta RPC submit_quiz_result / get_my_quiz_results).
  factory QuizResult.fromJson(Map<String, dynamic> json) {
    final rawAnswers = json['answers'];
    List<int> answers;
    if (rawAnswers is List) {
      answers = rawAnswers.map((e) => (e as num).toInt()).toList();
    } else {
      answers = [];
    }
    return QuizResult(
      quizId: json['quiz_id'] as String? ?? '',
      totalQuestions: json['total_questions'] as int? ?? 0,
      correctAnswers: json['correct_answers'] as int? ?? 0,
      answers: answers,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : DateTime.now(),
      earnedPoints: json['earned_points'] as int? ?? 0,
    );
  }

  double get score => correctAnswers / totalQuestions;
  int get percentage => (score * 100).round();
  bool get passed => score >= 0.6;

  String get resultLabel {
    if (percentage >= 90) return 'Eccellente!';
    if (percentage >= 80) return 'Ottimo!';
    if (percentage >= 70) return 'Buono';
    if (percentage >= 60) return 'Superato';
    return 'Non superato';
  }

  Color get resultColor {
    if (percentage >= 80) return const Color(0xFF4CAF50);
    if (percentage >= 60) return const Color(0xFFFF9800);
    return const Color(0xFFE53935);
  }
}
