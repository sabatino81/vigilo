import 'package:flutter/material.dart';
import 'package:vigilo/features/impara/domain/models/training_content.dart';

/// Elemento To-Do formativo del giorno
class TrainingTodo {
  const TrainingTodo({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.points,
    this.durationMinutes,
    this.contentId,
    this.quizId,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final ContentType type;
  final int points;
  final int? durationMinutes;
  final String? contentId;
  final String? quizId;
  final bool isCompleted;

  String get actionLabel {
    switch (type) {
      case ContentType.quiz:
        return 'Inizia Quiz';
      case ContentType.video:
        return 'Guarda Video';
      case ContentType.pdf:
        return 'Apri PDF';
      case ContentType.lesson:
        return 'Apri Lezione';
    }
  }

  IconData get icon => type.icon;
  Color get color => type.color;

  /// Mock data - To-do del giorno
  static List<TrainingTodo> dailyTodos() {
    return const [
      TrainingTodo(
        id: 'todo_1',
        title: 'Quiz settimanale',
        description: '10 domande sulla sicurezza',
        type: ContentType.quiz,
        points: 20,
        durationMinutes: 5,
        quizId: 'quiz_weekly',
      ),
      TrainingTodo(
        id: 'todo_2',
        title: 'Video "Uso sicuro DPI"',
        description: 'Video obbligatorio',
        type: ContentType.video,
        points: 10,
        durationMinutes: 4,
        contentId: 'video_1',
      ),
      TrainingTodo(
        id: 'todo_3',
        title: 'Micro-learning Scivolamenti',
        description: 'Come evitare scivolamenti',
        type: ContentType.lesson,
        points: 10,
        durationMinutes: 3,
        contentId: 'video_2',
      ),
    ];
  }
}
