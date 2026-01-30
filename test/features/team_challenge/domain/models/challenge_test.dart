import 'package:test/test.dart';
import 'package:vigilo/features/team_challenge/domain/models/challenge.dart';

void main() {
  group('Challenge computed properties', () {
    test('progress is currentPoints / targetPoints', () {
      final ch = Challenge(
        id: 'ch1',
        title: 'Test',
        description: 'Desc',
        targetPoints: 5000,
        currentPoints: 2500,
        bonusPoints: 100,
        deadline: DateTime(2030, 1, 1),
        contributions: const [],
      );
      expect(ch.progress, 0.5);
    });

    test('progress is 0 when targetPoints is 0', () {
      final ch = Challenge(
        id: 'ch1',
        title: 'Test',
        description: 'Desc',
        targetPoints: 0,
        currentPoints: 0,
        bonusPoints: 0,
        deadline: DateTime(2030, 1, 1),
        contributions: const [],
      );
      expect(ch.progress, 0);
    });

    test('progressPercent clamps to 0-100', () {
      final ch = Challenge(
        id: 'ch1',
        title: 'Test',
        description: 'Desc',
        targetPoints: 100,
        currentPoints: 150, // exceeded
        bonusPoints: 0,
        deadline: DateTime(2030, 1, 1),
        contributions: const [],
      );
      expect(ch.progressPercent, 100);
    });

    test('remainingPoints clamps to 0', () {
      final ch = Challenge(
        id: 'ch1',
        title: 'Test',
        description: 'Desc',
        targetPoints: 100,
        currentPoints: 150,
        bonusPoints: 0,
        deadline: DateTime(2030, 1, 1),
        contributions: const [],
      );
      expect(ch.remainingPoints, 0);
    });

    test('remainingPoints is positive when not completed', () {
      final ch = Challenge(
        id: 'ch1',
        title: 'Test',
        description: 'Desc',
        targetPoints: 5000,
        currentPoints: 3000,
        bonusPoints: 0,
        deadline: DateTime(2030, 1, 1),
        contributions: const [],
      );
      expect(ch.remainingPoints, 2000);
    });
  });

  group('Challenge.fromJson', () {
    test('parses complete challenge with contributions', () {
      final json = {
        'id': 'ch1',
        'title': 'Zero Incidenti',
        'description': 'Nessun incidente',
        'target_points': 5000,
        'current_points': 3420,
        'bonus_points': 200,
        'deadline': '2030-06-15T23:59:59Z',
        'is_completed': false,
        'contributions': [
          {'name': 'Marco', 'points': 890},
          {'name': 'Ahmed', 'points': 720},
        ],
      };

      final ch = Challenge.fromJson(json);
      expect(ch.id, 'ch1');
      expect(ch.title, 'Zero Incidenti');
      expect(ch.targetPoints, 5000);
      expect(ch.currentPoints, 3420);
      expect(ch.bonusPoints, 200);
      expect(ch.isCompleted, isFalse);
      expect(ch.contributions, hasLength(2));
      expect(ch.contributions.first.name, 'Marco');
      expect(ch.contributions.first.points, 890);
    });

    test('handles empty contributions list', () {
      final json = {
        'id': 'ch2',
        'title': 'Test',
        'deadline': '2030-01-01T00:00:00Z',
      };

      final ch = Challenge.fromJson(json);
      expect(ch.contributions, isEmpty);
      expect(ch.targetPoints, 0);
      expect(ch.currentPoints, 0);
    });
  });

  group('ChallengeContribution.fromJson', () {
    test('parses correctly', () {
      final json = {'name': 'Marco R.', 'points': 890};
      final c = ChallengeContribution.fromJson(json);
      expect(c.name, 'Marco R.');
      expect(c.points, 890);
    });

    test('defaults missing fields', () {
      final c = ChallengeContribution.fromJson(<String, dynamic>{});
      expect(c.name, '');
      expect(c.points, 0);
    });
  });
}
