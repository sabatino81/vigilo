import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class TeamLeaderboardCard extends StatelessWidget {
  const TeamLeaderboardCard({super.key});

  // Static data
  static const String _teamName = 'Falchi Nord';
  static const int _teamScore = 840;

  static final List<Map<String, dynamic>> _members = [
    {
      'name': 'Ahmed R.',
      'status': 'Perfetto (0 errori)',
      'online': true,
      'stars': 5,
    },
    {
      'name': 'Luca B.',
      'status': 'Buono (1 richiamo)',
      'online': false,
      'stars': 4,
    },
    {
      'name': 'Maria S.',
      'status': 'Ottimo (0 errori)',
      'online': true,
      'stars': 5,
    },
    {
      'name': 'Diego P.',
      'status': 'Perfetto',
      'online': false,
      'stars': 5,
    },
    {
      'name': 'Sofia K.',
      'status': 'Nuova',
      'online': true,
      'stars': 0,
    },
  ];

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
          color: AppTheme.tertiary.withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.tertiary.withValues(alpha: isDark ? 0.15 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: AppTheme.tertiary,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.teamLabel ?? 'Squadra',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.neutral,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      _teamName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppTheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_teamScore ${l10n?.pointsAbbr ?? 'pt'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Members section
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.people_rounded,
                  color: AppTheme.tertiary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.teamMembers ?? 'MEMBRI SQUADRA',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Members list
          ...List.generate(_members.length, (index) {
            final member = _members[index];
            return _buildMemberItem(
              member['name'] as String,
              member['status'] as String,
              member['online'] as bool,
              member['stars'] as int,
              isDark,
              l10n,
            );
          }),

          const SizedBox(height: 8),

          // Chat button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
              },
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
              label: Text(l10n?.openTeamChat ?? 'Apri chat squadra'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.tertiary,
                side: BorderSide(
                  color: AppTheme.tertiary.withValues(alpha: 0.5),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Expandable leaderboard
          _LeaderboardSection(isDark: isDark, l10n: l10n),
        ],
      ),
    );
  }

  Widget _buildMemberItem(
    String name,
    String status,
    bool online,
    int stars,
    bool isDark,
    AppLocalizations? l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Avatar with online indicator
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.05),
                child: Text(
                  name[0],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: online ? AppTheme.secondary : AppTheme.neutral,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF2A2A2A)
                          : Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Name and status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (stars > 0) ...[
                      const Icon(
                        Icons.star_rounded,
                        color: AppTheme.primary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.neutral,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Online status text
          Text(
            online
                ? (l10n?.online ?? 'Online')
                : (l10n?.offline ?? 'Offline'),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: online ? AppTheme.secondary : AppTheme.neutral,
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardSection extends StatefulWidget {
  const _LeaderboardSection({required this.isDark, required this.l10n});

  final bool isDark;
  final AppLocalizations? l10n;

  @override
  State<_LeaderboardSection> createState() => _LeaderboardSectionState();
}

class _LeaderboardSectionState extends State<_LeaderboardSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          behavior: HitTestBehavior.opaque,
          child: Row(
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
                  widget.l10n?.leaderboard ?? 'CLASSIFICA',
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
                      widget.l10n?.live ?? 'LIVE',
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
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.expand_more_rounded,
                  color: widget.isDark ? Colors.white54 : Colors.black45,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: List.generate(
                  TeamLeaderboardCard._teams.length, (index) {
                final team = TeamLeaderboardCard._teams[index];
                return _buildLeaderboardItem(
                  index + 1,
                  team['name'] as String,
                  team['score'] as int,
                  team['trend'] as String,
                  team['isUs'] as bool,
                  widget.isDark,
                );
              }),
            ),
          ),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
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
