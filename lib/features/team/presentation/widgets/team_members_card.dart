import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class TeamMembersCard extends StatelessWidget {
  const TeamMembersCard({super.key});

  // Static data
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
          const SizedBox(height: 16),

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

          const SizedBox(height: 12),

          // Action button
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
