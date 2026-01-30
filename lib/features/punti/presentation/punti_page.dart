import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/reward.dart';
import 'package:vigilo/features/punti/providers/wallet_providers.dart';
import 'package:vigilo/features/shop/presentation/pages/shop_page.dart';
import 'package:vigilo/features/punti/presentation/pages/rewards_catalog_sheet.dart';
import 'package:vigilo/features/punti/presentation/pages/spin_wheel_page.dart';
import 'package:vigilo/features/punti/presentation/widgets/elmetto_wallet_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/instant_win_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/leaderboard_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/points_stats_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/rewards_catalog_preview.dart';

/// Pagina principale Punti — ConsumerWidget con dati da Supabase.
class PuntiPage extends ConsumerWidget {
  const PuntiPage({super.key});

  void _openCatalog(
    BuildContext context,
    List<Reward> rewards,
    int userPoints, {
    Reward? initialReward,
  }) {
    unawaited(HapticFeedback.lightImpact());
    unawaited(
      RewardsCatalogSheet.show(
        context,
        rewards: rewards,
        userPoints: userPoints,
        initialReward: initialReward,
      ),
    );
  }

  Future<void> _openSpinWheel(
    BuildContext context,
    WidgetRef ref,
    bool hasSpinAvailable,
    int currentPoints,
  ) async {
    unawaited(HapticFeedback.mediumImpact());
    final wonPoints = await Navigator.of(context).push<int>(
      MaterialPageRoute<int>(
        builder: (context) => SpinWheelPage(
          hasSpinAvailable: hasSpinAvailable,
          currentPoints: currentPoints,
        ),
      ),
    );

    if (wonPoints != null && wonPoints >= 0) {
      // Ricarica wallet e stats dal server
      ref.invalidate(walletProvider);
      ref.invalidate(pointsStatsProvider);
      ref.invalidate(todaySpinProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletProvider);
    final rewardsAsync = ref.watch(rewardsProvider);
    final leaderboardAsync = ref.watch(leaderboardProvider);
    final statsAsync = ref.watch(pointsStatsProvider);
    final todaySpinAsync = ref.watch(todaySpinProvider);

    // Estrai dati con fallback per rendering progressivo
    final wallet = walletAsync.when(
      data: (w) => w,
      loading: () => null,
      error: (_, __) => null,
    );
    final rewards = rewardsAsync.when(
      data: (r) => r,
      loading: () => <Reward>[],
      error: (_, __) => <Reward>[],
    );
    final leaderboard = leaderboardAsync.when(
      data: (l) => l,
      loading: () => null,
      error: (_, __) => null,
    );
    final stats = statsAsync.when(
      data: (s) => s,
      loading: () => null,
      error: (_, __) => null,
    );
    final hasSpinAvailable = todaySpinAsync.when(
      data: (s) => s,
      loading: () => false,
      error: (_, __) => false,
    );

    final totalPoints = wallet?.puntiElmetto ?? 0;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(walletProvider);
          ref.invalidate(rewardsProvider);
          ref.invalidate(leaderboardProvider);
          ref.invalidate(pointsStatsProvider);
          ref.invalidate(todaySpinProvider);
        },
        child: walletAsync.when(
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Errore: $e')),
          data: (_) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dual Wallet Card
                if (wallet != null) ElmettoWalletCard(wallet: wallet),
                const SizedBox(height: 16),

                // Shop entry point
                _ShopEntryCard(
                  onTap: () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => const ShopPage(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Catalogo Premi Preview
                if (rewards.isNotEmpty)
                  RewardsCatalogPreview(
                    rewards: rewards,
                    userPoints: totalPoints,
                    onRewardTap: (reward) => _openCatalog(
                      context,
                      rewards,
                      totalPoints,
                      initialReward: reward,
                    ),
                    onViewAllTap: () => _openCatalog(
                      context,
                      rewards,
                      totalPoints,
                    ),
                  ),
                const SizedBox(height: 16),

                // Statistiche
                if (stats != null) PointsStatsCard(stats: stats),
                const SizedBox(height: 16),

                // Classifica
                if (leaderboard != null)
                  LeaderboardCard(entries: leaderboard),
                const SizedBox(height: 16),

                // Instant Win
                InstantWinCard(
                  hasSpinAvailable: hasSpinAvailable,
                  onSpinTap: () => _openSpinWheel(
                    context,
                    ref,
                    hasSpinAvailable,
                    totalPoints,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopEntryCard extends StatelessWidget {
  const _ShopEntryCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppTheme.ambra.withValues(alpha: 0.15),
                    AppTheme.teal.withValues(alpha: 0.15),
                  ]
                : [
                    AppTheme.ambra.withValues(alpha: 0.1),
                    AppTheme.teal.withValues(alpha: 0.1),
                  ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.ambra.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.ambra.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.storefront_rounded,
                color: AppTheme.ambra,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spaccio Aziendale',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Il tuo negozio riservato: sconti e prodotti gratis',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: isDark ? Colors.white38 : Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}
