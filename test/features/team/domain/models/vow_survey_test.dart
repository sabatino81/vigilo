import 'package:test/test.dart';
import 'package:vigilo/features/team/domain/models/vow_survey.dart';

void main() {
  group('VowSurvey computed properties', () {
    test('answeredCount returns number of answers', () {
      final survey = VowSurvey(
        id: 's1',
        questions: VowQuestion.mockQuestions(),
        answers: {
          'vow_1': const VowAnswer(questionId: 'vow_1', rating: 4),
          'vow_2': const VowAnswer(questionId: 'vow_2', rating: 3),
        },
      );
      expect(survey.answeredCount, 2);
    });

    test('totalQuestions returns questions length', () {
      final survey = VowSurvey(
        id: 's1',
        questions: VowQuestion.mockQuestions(),
        answers: const {},
      );
      expect(survey.totalQuestions, 5);
    });

    test('isComplete true when all answered', () {
      final questions = VowQuestion.mockQuestions();
      final answers = <String, VowAnswer>{};
      for (final q in questions) {
        answers[q.id] = VowAnswer(questionId: q.id, rating: 4);
      }
      final survey = VowSurvey(
        id: 's1',
        questions: questions,
        answers: answers,
      );
      expect(survey.isComplete, isTrue);
    });

    test('isComplete false when partially answered', () {
      final survey = VowSurvey(
        id: 's1',
        questions: VowQuestion.mockQuestions(),
        answers: const {
          'vow_1': VowAnswer(questionId: 'vow_1', rating: 4),
        },
      );
      expect(survey.isComplete, isFalse);
    });

    test('averageRating computes correctly', () {
      final survey = VowSurvey(
        id: 's1',
        questions: VowQuestion.mockQuestions(),
        answers: const {
          'vow_1': VowAnswer(questionId: 'vow_1', rating: 4),
          'vow_2': VowAnswer(questionId: 'vow_2', rating: 2),
        },
      );
      expect(survey.averageRating, 3.0);
    });

    test('averageRating is 0 for empty answers', () {
      final survey = VowSurvey(
        id: 's1',
        questions: VowQuestion.mockQuestions(),
        answers: const {},
      );
      expect(survey.averageRating, 0);
    });
  });

  group('VowSurvey.ratingLabel', () {
    test('returns correct labels for all ratings', () {
      expect(VowSurvey.ratingLabel(1), 'Per niente');
      expect(VowSurvey.ratingLabel(2), 'Poco');
      expect(VowSurvey.ratingLabel(3), 'Abbastanza');
      expect(VowSurvey.ratingLabel(4), 'Molto');
      expect(VowSurvey.ratingLabel(5), 'Assolutamente');
      expect(VowSurvey.ratingLabel(0), '');
    });
  });

  group('VowAnswer.copyWith', () {
    test('changes rating', () {
      const answer = VowAnswer(questionId: 'q1', rating: 3);
      final updated = answer.copyWith(rating: 5);
      expect(updated.rating, 5);
      expect(updated.questionId, 'q1');
    });
  });
}
