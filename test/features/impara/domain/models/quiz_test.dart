import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/impara/domain/models/quiz.dart';

void main() {
  group('QuizQuestion.isCorrect', () {
    const question = QuizQuestion(
      id: 'q1',
      text: 'What is 2+2?',
      options: ['3', '4', '5'],
      correctIndex: 1,
    );

    test('returns true for matching index', () {
      expect(question.isCorrect(1), true);
    });

    test('returns false for wrong index', () {
      expect(question.isCorrect(0), false);
      expect(question.isCorrect(2), false);
    });
  });

  group('QuizQuestion.fromJson', () {
    test('parses options list correctly', () {
      final json = <String, dynamic>{
        'id': 'q1',
        'text': 'Question?',
        'options': ['A', 'B', 'C'],
        'correct_index': 2,
        'explanation': 'Because C',
      };

      final q = QuizQuestion.fromJson(json);

      expect(q.id, 'q1');
      expect(q.text, 'Question?');
      expect(q.options, ['A', 'B', 'C']);
      expect(q.correctIndex, 2);
      expect(q.explanation, 'Because C');
    });

    test('handles missing options as empty list', () {
      final json = <String, dynamic>{
        'id': 'q2',
        'text': 'No options',
      };

      final q = QuizQuestion.fromJson(json);

      expect(q.options, isEmpty);
      expect(q.correctIndex, 0);
      expect(q.explanation, isNull);
    });
  });

  group('Quiz.fromJson', () {
    test('parses nested questions', () {
      final json = <String, dynamic>{
        'id': 'quiz_1',
        'title': 'Safety Quiz',
        'description': 'A safety quiz',
        'points': 20,
        'category': 'safety',
        'estimated_minutes': 10,
        'max_attempts': 3,
        'passing_score': 0.7,
        'questions': [
          {
            'id': 'q1',
            'text': 'Q1?',
            'options': ['A', 'B'],
            'correct_index': 0,
          },
          {
            'id': 'q2',
            'text': 'Q2?',
            'options': ['X', 'Y'],
            'correct_index': 1,
          },
        ],
      };

      final quiz = Quiz.fromJson(json);

      expect(quiz.id, 'quiz_1');
      expect(quiz.title, 'Safety Quiz');
      expect(quiz.questions.length, 2);
      expect(quiz.questions[0].id, 'q1');
      expect(quiz.questions[1].id, 'q2');
      expect(quiz.points, 20);
      expect(quiz.estimatedMinutes, 10);
      expect(quiz.maxAttempts, 3);
      expect(quiz.passingScore, 0.7);
    });

    test('filters non-map items from questions', () {
      final json = <String, dynamic>{
        'id': 'quiz_2',
        'title': 'Test',
        'description': '',
        'points': 10,
        'questions': [
          'not_a_map',
          42,
          {
            'id': 'q1',
            'text': 'Valid',
            'options': ['A'],
            'correct_index': 0,
          },
        ],
      };

      final quiz = Quiz.fromJson(json);

      expect(quiz.questions.length, 1);
      expect(quiz.questions.first.id, 'q1');
    });

    test('defaults passingScore to 0.6', () {
      final json = <String, dynamic>{
        'id': 'quiz_3',
        'title': '',
        'description': '',
        'points': 0,
        'questions': <dynamic>[],
      };

      final quiz = Quiz.fromJson(json);

      expect(quiz.passingScore, 0.6);
      expect(quiz.estimatedMinutes, 5);
      expect(quiz.maxAttempts, 1);
    });
  });

  group('QuizResult computed', () {
    QuizResult _result({
      int totalQuestions = 10,
      int correctAnswers = 8,
    }) {
      return QuizResult(
        quizId: 'quiz_1',
        totalQuestions: totalQuestions,
        correctAnswers: correctAnswers,
        answers: List.filled(totalQuestions, 0),
        completedAt: DateTime(2025, 1, 1),
        earnedPoints: 20,
      );
    }

    test('score is correctAnswers / totalQuestions', () {
      final result = _result(totalQuestions: 10, correctAnswers: 8);
      expect(result.score, 0.8);
    });

    test('percentage rounds correctly', () {
      final result = _result(totalQuestions: 10, correctAnswers: 7);
      expect(result.percentage, 70);
    });

    test('passed true when score >= 0.6', () {
      final result = _result(totalQuestions: 10, correctAnswers: 6);
      expect(result.passed, true);
    });

    test('passed false when score < 0.6', () {
      final result = _result(totalQuestions: 10, correctAnswers: 5);
      expect(result.passed, false);
    });

    test('resultLabel Eccellente for 90%', () {
      final result = _result(totalQuestions: 10, correctAnswers: 9);
      expect(result.resultLabel, 'Eccellente!');
    });

    test('resultLabel Ottimo for 80%', () {
      final result = _result(totalQuestions: 10, correctAnswers: 8);
      expect(result.resultLabel, 'Ottimo!');
    });

    test('resultLabel Buono for 70%', () {
      final result = _result(totalQuestions: 10, correctAnswers: 7);
      expect(result.resultLabel, 'Buono');
    });

    test('resultLabel Superato for 60%', () {
      final result = _result(totalQuestions: 10, correctAnswers: 6);
      expect(result.resultLabel, 'Superato');
    });

    test('resultLabel Non superato for 50%', () {
      final result = _result(totalQuestions: 10, correctAnswers: 5);
      expect(result.resultLabel, 'Non superato');
    });
  });

  group('QuizResult.fromJson', () {
    test('parses answers list', () {
      final json = <String, dynamic>{
        'quiz_id': 'quiz_1',
        'total_questions': 10,
        'correct_answers': 8,
        'answers': [0, 1, 2, 1, 0, 2, 1, 0, 1, 2],
        'completed_at': '2025-01-01T12:00:00Z',
        'earned_points': 20,
      };

      final result = QuizResult.fromJson(json);

      expect(result.quizId, 'quiz_1');
      expect(result.totalQuestions, 10);
      expect(result.correctAnswers, 8);
      expect(result.answers.length, 10);
      expect(result.answers[0], 0);
      expect(result.answers[2], 2);
      expect(result.earnedPoints, 20);
    });

    test('handles missing answers as empty list', () {
      final json = <String, dynamic>{
        'quiz_id': 'quiz_2',
        'total_questions': 5,
        'correct_answers': 3,
        'completed_at': '2025-06-15T10:00:00Z',
        'earned_points': 10,
      };

      final result = QuizResult.fromJson(json);

      expect(result.answers, isEmpty);
      expect(result.quizId, 'quiz_2');
    });
  });
}
