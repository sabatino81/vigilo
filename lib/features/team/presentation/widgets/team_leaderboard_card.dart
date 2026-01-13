import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class TeamLeaderboardCard extends StatelessWidget {
  const TeamLeaderboardCard({super.key});

  // Static data
  static final List<Map<String, dynamic>> _teams = [
    {'name': 'Falchi Nord', 'score': 840, 'trend': 'up', 'isUs': true},
    {'name': 'Tigri Est', 'score': 790, 'trend': 'down', 'isUs': false},
    {'name': 'Squadra Omega', 'score': 720, 'trend': 'same', 'isUs': false},
    {'name': 'Aquile Sud', 'score': 680, 'trend': 'same', 'isUs': false},
    {'name': 'Delta Crew', 'score': 600, 'trend': 'up', 'isUs': false},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

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
                  color: AppTheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.leaderboard_rounded,
                  color: AppTheme.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n?.leaderboard ?? 'CLASSIFICA',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n?.live ?? 'LIVE',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.secondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Leaderboard items
          ...List.generate(_teams.length, (index) {
            final team = _teams[index];
            return _buildLeaderboardItem(
              index + 1,
              team['name'] as String,
              team['score'] as int,
              team['trend'] as String,
              team['isUs'] as bool,
              isDark,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(
    int position,
    String name,
    int score,
    String trend,
    bool isUs,
    bool isDark,
  ) {
    final trendIcon = switch (trend) {
      'up' => Icons.arrow_upward_rounded,
      'down' => Icons.arrow_downward_rounded,
      _ => Icons.remove_rounded,
    };
    final trendColor = switch (trend) {
      'up' => AppTheme.secondary,
      'down' => AppTheme.danger,
      _ => AppTheme.neutral,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isUs
            ? AppTheme.tertiary.withValues(alpha: 0.15)
            : (isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.03)),
        borderRadius: BorderRadius.circular(12),
        border: isUs
            ? Border.all(
                color: AppTheme.tertiary.withValues(alpha: 0.4),
              )
            : null,
      ),
      child: Row(
        children: [
          // Position
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _getPositionColor(position),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$position',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: position <= 3 ? Colors.white : AppTheme.neutral,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Team name
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isUs ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          // Score
          Text(
            '$score pt',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          // Trend
          Icon(
            trendIcon,
            color: trendColor,
            size: 18,
          ),
        ],
      ),
    );
  }

  Color _getPositionColor(int position) {
    return switch (position) {
      1 => const Color(0xFFFFD700), // Gold
      2 => const Color(0xFFC0C0C0), // Silver
      3 => const Color(0xFFCD7F32), // Bronze
      _ => Colors.grey.withValues(alpha: 0.3),
    };
  }
}
