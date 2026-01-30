import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/profile/providers/profile_providers.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

/// Card Safety Score sulla HomePage — ConsumerWidget con dati da profileProvider.
class SafetyScoreCard extends ConsumerWidget {
  const SafetyScoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final profileAsync = ref.watch(profileProvider);
    final score = profileAsync.when(
      data: (p) => p.safetyScore,
      loading: () => 0,
      error: (_, __) => 0,
    );

    final metrics = {
      l10n?.metricStress ?? 'Stress': 2,
      l10n?.metricHydration ?? 'Idratazione': 3,
      l10n?.metricFatigue ?? 'Fatica': 2,
      l10n?.metricRest ?? 'Riposo': 4,
    };

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.black.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: AppTheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.safetyScore ?? 'SAFETY SCORE',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Score display
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: _getScoreColor(score),
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  l10n?.scoreOutOf ?? '/ 100',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.neutral,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.trending_up_rounded,
                      color: AppTheme.secondary,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+3 ${l10n?.trendVsYesterday ?? 'vs ieri'}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 12,
              backgroundColor: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.08),
              valueColor:
                  AlwaysStoppedAnimation<Color>(_getScoreColor(score)),
            ),
          ),
          const SizedBox(height: 24),

          // Metrics grid
          Column(
            children: metrics.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildMetricItem(entry.key, entry.value, isDark),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, int value, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.neutral,
            ),
          ),
        ),
        ...List.generate(4, (index) {
          final isActive = index < value;
          return Container(
            width: 16,
            height: 16,
            margin: EdgeInsets.only(left: index > 0 ? 6 : 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? _getMetricColor(label)
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.1)),
            ),
          );
        }),
      ],
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return AppTheme.secondary;
    if (score >= 60) return AppTheme.primary;
    if (score >= 40) return AppTheme.warning;
    return AppTheme.danger;
  }

  Color _getMetricColor(String label) {
    // Match by checking if label contains key words
    if (label.toLowerCase().contains('stress')) return AppTheme.warning;
    if (label.toLowerCase().contains('idrat') ||
        label.toLowerCase().contains('hydrat')) return AppTheme.tertiary;
    if (label.toLowerCase().contains('fatica') ||
        label.toLowerCase().contains('fatigue')) return AppTheme.danger;
    if (label.toLowerCase().contains('riposo') ||
        label.toLowerCase().contains('rest')) return AppTheme.secondary;
    return AppTheme.primary;
  }
}
