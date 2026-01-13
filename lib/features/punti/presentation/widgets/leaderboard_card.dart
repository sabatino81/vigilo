import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/leaderboard_entry.dart';

/// Card classifica individuale
class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({
    required this.entries,
    super.key,
  });

  final List<LeaderboardEntry> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
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
                  color: AppTheme.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.leaderboard_rounded,
                  color: AppTheme.warning,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'CLASSIFICA',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppTheme.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        fontSize: 10,
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

          // Lista classifica
          ...entries.map(
            (entry) => _LeaderboardTile(entry: entry, isDark: isDark),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  const _LeaderboardTile({
    required this.entry,
    required this.isDark,
  });

  final LeaderboardEntry entry;
  final bool isDark;

  Color get _rankColor {
    switch (entry.rank) {
      case 1:
        return const Color(0xFFFFD700); // Oro
      case 2:
        return const Color(0xFFC0C0C0); // Argento
      case 3:
        return const Color(0xFFCD7F32); // Bronzo
      default:
        return isDark ? Colors.white54 : Colors.black45;
    }
  }

  Color get _trendColor {
    switch (entry.trend) {
      case RankTrend.up:
        return AppTheme.secondary;
      case RankTrend.down:
        return AppTheme.danger;
      case RankTrend.same:
        return isDark ? Colors.white38 : Colors.black26;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: entry.isCurrentUser
            ? AppTheme.primary.withValues(alpha: 0.15)
            : isDark
                ? Colors.white.withValues(alpha: 0.03)
                : Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: entry.isCurrentUser
            ? Border.all(
                color: AppTheme.primary.withValues(alpha: 0.3),
              )
            : null,
      ),
      child: Row(
        children: [
          // Rank
          SizedBox(
            width: 28,
            child: Text(
              '${entry.rank}.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: _rankColor,
              ),
            ),
          ),
          // Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: entry.isCurrentUser
                  ? AppTheme.primary.withValues(alpha: 0.3)
                  : isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                entry.name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: entry.isCurrentUser
                      ? AppTheme.primary
                      : isDark
                          ? Colors.white70
                          : Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Nome
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    entry.isCurrentUser ? 'TU' : entry.name,
                    style: TextStyle(
                      fontWeight:
                          entry.isCurrentUser ? FontWeight.w700 : FontWeight.w500,
                      color: entry.isCurrentUser
                          ? AppTheme.primary
                          : isDark
                              ? Colors.white
                              : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (entry.isCurrentUser) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.person_rounded,
                    size: 14,
                    color: AppTheme.primary,
                  ),
                ],
              ],
            ),
          ),
          // Punti
          Text(
            '${entry.points} pt',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          // Trend
          Text(
            entry.trend.icon,
            style: TextStyle(
              fontSize: 14,
              color: _trendColor,
            ),
          ),
        ],
      ),
    );
  }
}
