import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/notifications/presentation/pages/notifications_page.dart';
import 'package:vigilo/features/profile/presentation/pages/profile_page.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';
import 'package:vigilo/features/punti/providers/wallet_providers.dart';

class AppHeader extends ConsumerWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          // Avatar with gradient border -> navigate to profile
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primary,
                    AppTheme.secondary,
                  ],
                ),
              ),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: theme.colorScheme.surface,
                child: const Icon(
                  Icons.person_rounded,
                  color: AppTheme.primary,
                  size: 26,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n?.hello ?? 'Ciao!',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.neutral,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Ranieri Ricciardi',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                _PointsBadge(ref: ref),
              ],
            ),
          ),
          // Notification button -> navigate to notifications
          _GlassIconButton(
            icon: Icons.notifications_outlined,
            badgeCount: 3,
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (_) => const NotificationsPage(),
                ),
              );
            },
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _PointsBadge extends StatelessWidget {
  const _PointsBadge({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final walletAsync = ref.watch(walletProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return walletAsync.when(
      data: (wallet) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.tertiary.withValues(alpha: isDark ? 0.25 : 0.15),
              AppTheme.primary.withValues(alpha: isDark ? 0.15 : 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.tertiary.withValues(alpha: isDark ? 0.4 : 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '\u26D1',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(width: 5),
            Text(
              '${_formatPoints(wallet.puntiElmetto)} Punti Elmetto',
              style: TextStyle(
                color: isDark ? AppTheme.primary : AppTheme.tertiary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  String _formatPoints(int points) {
    if (points >= 1000) {
      final k = points / 1000;
      return k == k.truncateToDouble()
          ? '${k.toInt()}K'
          : '${k.toStringAsFixed(1)}K';
    }
    return points.toString();
  }
}

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
    this.badgeCount,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: theme.colorScheme.onSurface,
              size: 22,
            ),
            if (badgeCount != null && badgeCount! > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppTheme.danger,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      badgeCount! > 9 ? '9+' : badgeCount.toString(),
                      style: const TextStyle(
                        color: AppTheme.onDanger,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

