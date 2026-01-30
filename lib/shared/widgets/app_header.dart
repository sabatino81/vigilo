import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/notifications/presentation/pages/notifications_page.dart';
import 'package:vigilo/features/profile/presentation/pages/profile_page.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';
import 'package:vigilo/features/punti/providers/wallet_providers.dart';
import 'package:vigilo/providers/locale_provider.dart';
import 'package:vigilo/providers/theme_provider.dart';

class AppHeader extends ConsumerWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
          const SizedBox(width: 8),
          // Settings menu
          _SettingsMenuButton(ref: ref, l10n: l10n, isDark: isDark),
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

    return walletAsync.when(
      data: (wallet) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.hardware_rounded,
            size: 14,
            color: AppTheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            '${wallet.puntiElmetto} pt',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
          ),
        ],
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
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

class _SettingsMenuButton extends StatelessWidget {
  const _SettingsMenuButton({
    required this.ref,
    required this.isDark,
    this.l10n,
  });

  final WidgetRef ref;
  final AppLocalizations? l10n;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLocale = ref.watch(localeProvider);
    final currentTheme = ref.watch(themeProvider);

    return PopupMenuButton<String>(
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
        child: Icon(
          Icons.settings_outlined,
          color: theme.colorScheme.onSurface,
          size: 22,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      offset: const Offset(0, 52),
      itemBuilder: (context) => [
        // Header
        PopupMenuItem<String>(
          enabled: false,
          height: 48,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.language_rounded,
                  size: 18,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.language ?? 'Lingua',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        _buildLanguageItem(
          context,
          'it',
          'Italiano',
          '🇮🇹',
          currentLocale.languageCode == 'it',
        ),
        _buildLanguageItem(
          context,
          'en',
          'English',
          '🇬🇧',
          currentLocale.languageCode == 'en',
        ),
        const PopupMenuDivider(height: 16),
        // Theme header
        PopupMenuItem<String>(
          enabled: false,
          height: 48,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.tertiaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  currentTheme == ThemeMode.dark
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  size: 18,
                  color: AppTheme.tertiary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.theme ?? 'Tema',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        _buildThemeItem(
          context,
          'theme_light',
          l10n?.themeLight ?? 'Chiaro',
          Icons.light_mode_rounded,
          currentTheme == ThemeMode.light,
        ),
        _buildThemeItem(
          context,
          'theme_dark',
          l10n?.themeDark ?? 'Scuro',
          Icons.dark_mode_rounded,
          currentTheme == ThemeMode.dark,
        ),
        _buildThemeItem(
          context,
          'theme_system',
          l10n?.themeSystem ?? 'Sistema',
          Icons.auto_mode_rounded,
          currentTheme == ThemeMode.system,
        ),
        const PopupMenuDivider(height: 16),
        // Logout
        PopupMenuItem<String>(
          value: 'logout',
          height: 48,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.dangerContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.logout_rounded,
                  size: 20,
                  color: AppTheme.danger,
                ),
                const SizedBox(width: 12),
                Text(
                  l10n?.logout ?? 'Logout',
                  style: const TextStyle(
                    color: AppTheme.danger,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      onSelected: (value) async {
        HapticFeedback.lightImpact();
        switch (value) {
          case 'lang_it':
            ref.read(localeProvider.notifier).setLocale(const Locale('it'));
          case 'lang_en':
            ref.read(localeProvider.notifier).setLocale(const Locale('en'));
          case 'theme_light':
            ref.read(themeProvider.notifier).setThemeMode(ThemeMode.light);
          case 'theme_dark':
            ref.read(themeProvider.notifier).setThemeMode(ThemeMode.dark);
          case 'theme_system':
            ref.read(themeProvider.notifier).setThemeMode(ThemeMode.system);
          case 'logout':
            await Supabase.instance.client.auth.signOut();
            if (context.mounted) {
              context.go('/login');
            }
        }
      },
    );
  }

  PopupMenuItem<String> _buildLanguageItem(
    BuildContext context,
    String code,
    String label,
    String flag,
    bool isSelected,
  ) {
    final theme = Theme.of(context);

    return PopupMenuItem<String>(
      value: 'lang_$code',
      height: 44,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryContainer.withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: AppTheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildThemeItem(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    bool isSelected,
  ) {
    final theme = Theme.of(context);

    return PopupMenuItem<String>(
      value: value,
      height: 44,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.tertiaryContainer.withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppTheme.tertiary : AppTheme.neutral,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: AppTheme.tertiary,
              ),
          ],
        ),
      ),
    );
  }
}
