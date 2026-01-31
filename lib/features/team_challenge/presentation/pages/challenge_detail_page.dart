import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/team_challenge/domain/models/challenge.dart';
import 'package:vigilo/features/team_challenge/providers/challenge_providers.dart';
import 'package:vigilo/shared/widgets/app_scaffold.dart';

/// Pagina dettaglio sfida team — ConsumerWidget con dati da Supabase.
class ChallengeDetailPage extends ConsumerWidget {
  const ChallengeDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final challengeAsync = ref.watch(activeChallengeProvider);
    final challenge = challengeAsync.when(
      data: (c) => c,
      loading: () => Challenge.mockChallenge(),
      error: (_, __) => Challenge.mockChallenge(),
    );

    final historyAsync = ref.watch(challengeHistoryProvider);
    final history = historyAsync.when(
      data: (h) => h,
      loading: () => <Challenge>[],
      error: (_, __) => <Challenge>[],
    );

    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          'Sfida Team',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: challenge == null
          ? Center(
              child: Text(
                'Nessuna sfida attiva',
                style: TextStyle(
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Challenge hero
                  _ChallengeHero(challenge: challenge, isDark: isDark),
                  const SizedBox(height: 20),

                  // Contributions
                  _ContributionsList(
                    contributions: challenge.contributions,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 20),

                  // History
                  _ChallengeHistory(history: history, isDark: isDark),
                ],
              ),
            ),
    );
  }
}

class _ChallengeHero extends StatelessWidget {
  const _ChallengeHero({
    required this.challenge,
    required this.isDark,
  });

  final Challenge challenge;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.tertiary.withValues(alpha: 0.12),
            AppTheme.secondary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.tertiary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.flag_rounded,
                color: AppTheme.tertiary,
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  challenge.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            challenge.description,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white54 : Colors.black45,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Progress bar
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: challenge.progress.clamp(0.0, 1.0),
                        backgroundColor: isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.06),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.tertiary,
                        ),
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${challenge.currentPoints} / '
                      '${challenge.targetPoints} punti',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${challenge.progressPercent}%',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Deadline + Bonus
          Row(
            children: [
              Icon(
                Icons.timer_rounded,
                size: 16,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
              const SizedBox(width: 6),
              Text(
                challenge.timeRemainingLabel,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.stars_rounded,
                size: 16,
                color: AppTheme.ambra,
              ),
              const SizedBox(width: 4),
              Text(
                'Bonus: +${challenge.bonusPoints} pt',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.ambra,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContributionsList extends StatelessWidget {
  const _ContributionsList({
    required this.contributions,
    required this.isDark,
  });

  final List<ChallengeContribution> contributions;
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
            'Contributi Team',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...contributions.asMap().entries.map((entry) {
            final idx = entry.key;
            final c = entry.value;
            final isTop = idx < 3;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    child: Text(
                      '${idx + 1}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isTop
                            ? AppTheme.ambra
                            : (isDark
                                ? Colors.white54
                                : Colors.black45),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      c.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isTop
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isDark
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    '${c.points} pt',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isTop
                          ? AppTheme.ambra
                          : (isDark
                              ? Colors.white54
                              : Colors.black45),
                    ),
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

class _ChallengeHistory extends StatelessWidget {
  const _ChallengeHistory({
    required this.history,
    required this.isDark,
  });

  final List<Challenge> history;
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
            'Storico Sfide',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...history.map(
            (ch) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppTheme.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ch.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        Text(
                          '${ch.currentPoints}/${ch.targetPoints} pt'
                          '  |  +${ch.bonusPoints} bonus',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
