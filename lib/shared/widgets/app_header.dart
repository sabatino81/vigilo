import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/notifications/presentation/pages/notifications_page.dart';
import 'package:vigilo/features/profile/presentation/pages/profile_page.dart';
import 'package:vigilo/features/shop/presentation/pages/cart_page.dart';
import 'package:vigilo/features/shop/providers/shop_providers.dart';
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
      padding: EdgeInsets.fromLTRB(
        15, MediaQuery.of(context).padding.top - 6, 15, 10,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.04),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
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
                radius: 15,
                backgroundColor: theme.colorScheme.surface,
                child: const Icon(
                  Icons.person_rounded,
                  color: AppTheme.primary,
                  size: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n?.hello ?? 'Ciao!',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.neutral,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'Ranieri Ricciardi',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -0.3,
                  ),
                  overflow: TextOverflow.ellipsis,
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
          if (ref.watch(cartProvider).isNotEmpty) ...[
            const SizedBox(width: 8),
            // Cart button -> navigate to cart
            _GlassIconButton(
              icon: Icons.shopping_cart_outlined,
              badgeCount: ref.watch(cartProvider).fold<int>(
                0,
                (sum, item) => sum + item.quantity,
              ),
              backgroundColor: AppTheme.secondary.withValues(alpha: 0.85),
              iconColor: Colors.white,
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => const CartPage(),
                  ),
                );
              },
              isDark: isDark,
            ),
          ],
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFB800).withValues(alpha: isDark ? 0.20 : 0.12),
              const Color(0xFFFF8C00).withValues(alpha: isDark ? 0.10 : 0.06),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFFFB800).withValues(alpha: isDark ? 0.5 : 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFB800).withValues(alpha: isDark ? 0.15 : 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.engineering_rounded,
              size: 14,
              color: Color(0xFFFFB800),
            ),
            const SizedBox(width: 5),
            Text(
              _formatPoints(wallet.puntiElmetto),
              style: const TextStyle(
                color: Color(0xFFFFB800),
                fontWeight: FontWeight.w900,
                fontSize: 13,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              'Punti Elmetto',
              style: TextStyle(
                color: const Color(0xFFFFB800).withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
                fontSize: 10,
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
    this.backgroundColor,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  final int? badgeCount;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: backgroundColor ??
              (isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.04)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? theme.colorScheme.onSurface,
              size: 20,
            ),
            if (badgeCount != null && badgeCount! > 0)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: AppTheme.danger,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.surface,
                      width: 1.5,
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

