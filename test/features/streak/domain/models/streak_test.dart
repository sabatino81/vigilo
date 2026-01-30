import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/streak/domain/models/streak.dart';

void main() {
  group('StreakLevel.fromDays', () {
    test('1 day returns fiammella', () {
      expect(StreakLevel.fromDays(1), StreakLevel.fiammella);
    });

    test('6 days returns fiammella', () {
      expect(StreakLevel.fromDays(6), StreakLevel.fiammella);
    });

    test('7 days returns fuocherello', () {
      expect(StreakLevel.fromDays(7), StreakLevel.fuocherello);
    });

    test('13 days returns fuocherello', () {
      expect(StreakLevel.fromDays(13), StreakLevel.fuocherello);
    });

    test('14 days returns falo', () {
      expect(StreakLevel.fromDays(14), StreakLevel.falo);
    });

    test('29 days returns falo', () {
      expect(StreakLevel.fromDays(29), StreakLevel.falo);
    });

    test('30 days returns incendio', () {
      expect(StreakLevel.fromDays(30), StreakLevel.incendio);
    });

    test('59 days returns incendio', () {
      expect(StreakLevel.fromDays(59), StreakLevel.incendio);
    });

    test('60 days returns inferno', () {
      expect(StreakLevel.fromDays(60), StreakLevel.inferno);
    });

    test('100 days returns inferno', () {
      expect(StreakLevel.fromDays(100), StreakLevel.inferno);
    });
  });

  group('StreakLevel.multiplier', () {
    test('fiammella multiplier is 1.0', () {
      expect(StreakLevel.fiammella.multiplier, 1.0);
    });

    test('fuocherello multiplier is 1.2', () {
      expect(StreakLevel.fuocherello.multiplier, 1.2);
    });

    test('falo multiplier is 1.5', () {
      expect(StreakLevel.falo.multiplier, 1.5);
    });

    test('incendio multiplier is 2.0', () {
      expect(StreakLevel.incendio.multiplier, 2.0);
    });

    test('inferno multiplier is 3.0', () {
      expect(StreakLevel.inferno.multiplier, 3.0);
    });
  });

  group('Streak computed', () {
    test('currentLevel delegates to fromDays', () {
      const streak = Streak(
        currentDays: 14,
        bestStreak: 28,
        calendarDays: [],
      );

      expect(streak.currentLevel, StreakLevel.falo);
    });

    test('multiplier returns level multiplier', () {
      const streak = Streak(
        currentDays: 30,
        bestStreak: 30,
        calendarDays: [],
      );

      expect(streak.multiplier, 2.0);
    });

    test('nextLevel for fiammella is fuocherello', () {
      const streak = Streak(
        currentDays: 3,
        bestStreak: 5,
        calendarDays: [],
      );

      expect(streak.nextLevel, StreakLevel.fuocherello);
    });

    test('nextLevel for inferno is null', () {
      const streak = Streak(
        currentDays: 60,
        bestStreak: 60,
        calendarDays: [],
      );

      expect(streak.nextLevel, isNull);
    });

    test('daysToNextLevel: 14 days falo next is incendio (30 - 14 = 16)', () {
      const streak = Streak(
        currentDays: 14,
        bestStreak: 14,
        calendarDays: [],
      );

      expect(streak.currentLevel, StreakLevel.falo);
      expect(streak.nextLevel, StreakLevel.incendio);
      expect(streak.daysToNextLevel, 16);
    });

    test('daysToNextLevel: inferno returns null', () {
      const streak = Streak(
        currentDays: 75,
        bestStreak: 75,
        calendarDays: [],
      );

      expect(streak.daysToNextLevel, isNull);
    });
  });

  group('Streak.fromJson', () {
    test('parses complete JSON', () {
      final json = <String, dynamic>{
        'current_days': 14,
        'best_streak': 28,
        'calendar_days': [1, 2, 3, 5, 7, 10, 12, 14],
      };

      final streak = Streak.fromJson(json);

      expect(streak.currentDays, 14);
      expect(streak.bestStreak, 28);
      expect(streak.calendarDays, [1, 2, 3, 5, 7, 10, 12, 14]);
    });

    test('handles missing calendar_days as empty list', () {
      final json = <String, dynamic>{
        'current_days': 5,
        'best_streak': 10,
      };

      final streak = Streak.fromJson(json);

      expect(streak.calendarDays, isEmpty);
    });

    test('defaults currentDays and bestStreak to 0', () {
      final json = <String, dynamic>{};

      final streak = Streak.fromJson(json);

      expect(streak.currentDays, 0);
      expect(streak.bestStreak, 0);
      expect(streak.calendarDays, isEmpty);
    });
  });
}
