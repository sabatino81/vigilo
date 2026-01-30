import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/features/streak/domain/models/streak.dart';
import 'package:vigilo/features/streak/providers/streak_providers.dart';

/// Pagina dettaglio streak con livelli, calendario e moltiplicatore — ConsumerWidget.
class StreakDetailPage extends ConsumerWidget {
  const StreakDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final streakAsync = ref.watch(streakProvider);
    final streak = streakAsync.when(
      data: (s) => s,
      loading: () => Streak.mockStreak(),
      error: (_, __) => Streak.mockStreak(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Streak',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
        child: Column(
          children: [
            // Current streak hero
            _StreakHero(streak: streak, isDark: isDark),
            const SizedBox(height: 20),

            // Calendar heatmap
            _CalendarHeatmap(streak: streak, isDark: isDark),
            const SizedBox(height: 20),

            // Level progression
            _LevelProgression(streak: streak, isDark: isDark),
            const SizedBox(height: 20),

            // Best streak
            _BestStreakCard(
              bestStreak: streak.bestStreak,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakHero extends StatelessWidget {
  const _StreakHero({required this.streak, required this.isDark});

  final Streak streak;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final level = streak.currentLevel;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            level.color.withValues(alpha: 0.15),
            level.color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: level.color.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Text(level.emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          Text(
            '${streak.currentDays} giorni',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            level.label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: level.color,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: level.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Moltiplicatore x${level.multiplier}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: level.color,
              ),
            ),
          ),
          if (streak.nextLevel != null) ...[
            const SizedBox(height: 8),
            Text(
              '${streak.daysToNextLevel} giorni al '
              '${streak.nextLevel!.label}',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CalendarHeatmap extends StatelessWidget {
  const _CalendarHeatmap({required this.streak, required this.isDark});

  final Streak streak;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth =
        DateTime(now.year, now.month + 1, 0).day;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calendario del mese',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(daysInMonth, (i) {
              final day = i + 1;
              final isActive = streak.calendarDays.contains(day);
              final isToday = day == now.day;
              final isFuture = day > now.day;

              return Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isFuture
                      ? Colors.transparent
                      : isActive
                          ? streak.currentLevel.color
                              .withValues(alpha: 0.8)
                          : isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.black
                                  .withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(6),
                  border: isToday
                      ? Border.all(
                          color: streak.currentLevel.color,
                          width: 2,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isToday
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: isActive
                          ? Colors.white
                          : isFuture
                              ? (isDark
                                  ? Colors.white12
                                  : Colors.black12)
                              : (isDark
                                  ? Colors.white54
                                  : Colors.black45),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _LevelProgression extends StatelessWidget {
  const _LevelProgression({
    required this.streak,
    required this.isDark,
  });

  final Streak streak;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Livelli Streak',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...StreakLevel.values.map((level) {
            final isCurrentOrPast =
                streak.currentDays >= level.minDays;
            final isCurrent = level == streak.currentLevel;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text(level.emoji, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          level.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isCurrent
                                ? FontWeight.w800
                                : FontWeight.w500,
                            color: isCurrentOrPast
                                ? level.color
                                : (isDark
                                    ? Colors.white38
                                    : Colors.black26),
                          ),
                        ),
                        Text(
                          '${level.minDays}+ giorni  |  '
                          'x${level.multiplier}',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? Colors.white38
                                : Colors.black26,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isCurrent)
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: level.color,
                      size: 18,
                    )
                  else if (isCurrentOrPast)
                    Icon(
                      Icons.check_circle_rounded,
                      color: level.color.withValues(alpha: 0.5),
                      size: 18,
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _BestStreakCard extends StatelessWidget {
  const _BestStreakCard({
    required this.bestStreak,
    required this.isDark,
  });

  final int bestStreak;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.emoji_events_rounded,
            color: isDark ? Colors.white54 : Colors.black45,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Record personale',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
                Text(
                  '$bestStreak giorni',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
