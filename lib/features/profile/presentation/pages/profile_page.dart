import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vigilo/core/data/async_data_view.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/profile/domain/models/user_profile.dart';
import 'package:vigilo/features/profile/providers/profile_providers.dart';
import 'package:vigilo/features/shop/presentation/pages/orders_page.dart';
import 'package:vigilo/providers/locale_provider.dart';
import 'package:vigilo/providers/theme_provider.dart';

/// Pagina profilo utente — ConsumerWidget con dati da Supabase.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profilo',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: AsyncDataView<UserProfile>(
        value: profileAsync,
        onRefresh: () =>
            ref.read(profileProvider.notifier).refresh(),
        builder: (profile) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
          child: Column(
            children: [
              // Avatar section
              _AvatarSection(profile: profile, isDark: isDark),
              const SizedBox(height: 20),

              // Wallet compact
              _WalletCompactCard(
                profile: profile,
                isDark: isDark,
              ),
              const SizedBox(height: 16),

              // Safety stats
              _SafetyStatsCard(
                profile: profile,
                isDark: isDark,
              ),
              const SizedBox(height: 16),

              // Trust level
              _TrustLevelCard(
                trustLevel: profile.trustLevel,
                isDark: isDark,
              ),
              const SizedBox(height: 16),

              // My Orders
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => const OrdersPage(),
                    ),
                  ),
                  icon: const Icon(Icons.receipt_long_rounded),
                  label: const Text('I miei ordini'),
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Settings shortcuts
              _SettingsCard(isDark: isDark),
              const SizedBox(height: 16),

              // Logout
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: AppTheme.danger,
                  ),
                  label: const Text(
                    'Esci',
                    style: TextStyle(color: AppTheme.danger),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.danger),
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarSection extends StatelessWidget {
  const _AvatarSection({
    required this.profile,
    required this.isDark,
  });

  final UserProfile profile;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppTheme.primary, AppTheme.secondary],
            ),
            border: Border.all(
              color: AppTheme.primary.withValues(alpha: 0.3),
              width: 3,
            ),
          ),
          child: Center(
            child: Text(
              profile.name
                  .split(' ')
                  .map((n) => n[0])
                  .take(2)
                  .join(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          profile.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              profile.category.icon,
              size: 16,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
            const SizedBox(width: 6),
            Text(
              profile.category.label,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              profile.companyName,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black26,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _WalletCompactCard extends StatelessWidget {
  const _WalletCompactCard({
    required this.profile,
    required this.isDark,
  });

  final UserProfile profile;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          // Elmetto
          Expanded(
            child: _WalletMiniBox(
              icon: Icons.construction_rounded,
              label: 'Punti Elmetto',
              value: '${profile.puntiElmetto} pt',
              color: AppTheme.ambra,
              isDark: isDark,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.06),
          ),
          // Welfare status
          Expanded(
            child: _WalletMiniBox(
              icon: Icons.favorite_rounded,
              label: 'Welfare',
              value: profile.welfareActive ? 'ATTIVO' : 'Non attivo',
              color: profile.welfareActive
                  ? AppTheme.teal
                  : AppTheme.neutral,
              isDark: isDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletMiniBox extends StatelessWidget {
  const _WalletMiniBox({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? Colors.white54 : Colors.black45,
          ),
        ),
      ],
    );
  }
}

class _SafetyStatsCard extends StatelessWidget {
  const _SafetyStatsCard({
    required this.profile,
    required this.isDark,
  });

  final UserProfile profile;
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
            'Statistiche Sicurezza',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatItem(
                icon: Icons.shield_rounded,
                value: '${profile.safetyScore}',
                label: 'Safety Score',
                color: AppTheme.secondary,
                isDark: isDark,
              ),
              _StatItem(
                icon: Icons.local_fire_department_rounded,
                value: '${profile.streakDays}g',
                label: 'Streak',
                color: AppTheme.ambra,
                isDark: isDark,
              ),
              _StatItem(
                icon: Icons.flag_rounded,
                value: '${profile.reportsCount}',
                label: 'Segnalazioni',
                color: AppTheme.tertiary,
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.isDark,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TrustLevelCard extends StatelessWidget {
  const _TrustLevelCard({
    required this.trustLevel,
    required this.isDark,
  });

  final TrustLevel trustLevel;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: trustLevel.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: trustLevel.color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(trustLevel.icon, color: trustLevel.color, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Livello Fiducia',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
                Text(
                  trustLevel.label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: trustLevel.color,
                  ),
                ),
              ],
            ),
          ),
          // Stars
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(4, (i) {
              return Icon(
                i < trustLevel.stars
                    ? Icons.star_rounded
                    : Icons.star_border_rounded,
                color: trustLevel.color,
                size: 20,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends ConsumerWidget {
  const _SettingsCard({required this.isDark});

  final bool isDark;

  static const _locales = [
    (Locale('it'), 'Italiano'),
    (Locale('en'), 'English'),
  ];

  static String _localeLabel(Locale locale) {
    for (final entry in _locales) {
      if (entry.$1.languageCode == locale.languageCode) return entry.$2;
    }
    return locale.languageCode.toUpperCase();
  }

  static String _themeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'Scuro';
      case ThemeMode.light:
        return 'Chiaro';
      case ThemeMode.system:
        return 'Sistema';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final currentTheme = ref.watch(themeProvider);

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Lingua
          _SettingsTile(
            icon: Icons.language_rounded,
            label: 'Lingua',
            value: _localeLabel(currentLocale),
            isDark: isDark,
            onTap: () {
              final currentIdx = _locales.indexWhere(
                (e) => e.$1.languageCode == currentLocale.languageCode,
              );
              final nextIdx = (currentIdx + 1) % _locales.length;
              ref
                  .read(localeProvider.notifier)
                  .setLocale(_locales[nextIdx].$1);
            },
          ),
          _SettingsDivider(isDark: isDark),
          // Tema
          _SettingsTile(
            icon: currentTheme == ThemeMode.dark
                ? Icons.dark_mode_rounded
                : Icons.light_mode_rounded,
            label: 'Tema',
            value: _themeLabel(currentTheme),
            isDark: isDark,
            onTap: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          _SettingsDivider(isDark: isDark),
          _SettingsTile(
            icon: Icons.notifications_rounded,
            label: 'Notifiche',
            value: 'Attive',
            isDark: isDark,
          ),
          _SettingsDivider(isDark: isDark),
          _SettingsTile(
            icon: Icons.fingerprint_rounded,
            label: 'Biometria',
            value: 'Attiva',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: isDark ? Colors.white24 : Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.04),
      ),
    );
  }
}
