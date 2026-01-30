import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/features/punti/providers/wallet_providers.dart';
import 'package:vigilo/features/punti/presentation/pages/spin_wheel_page.dart';
import 'package:vigilo/features/punti/presentation/widgets/elmetto_wallet_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/instant_win_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/leaderboard_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/points_stats_card.dart';
import 'package:vigilo/features/team/presentation/widgets/team_leaderboard_card.dart';

/// Pagina principale Punti — ConsumerWidget con dati da Supabase.
class PuntiPage extends ConsumerWidget {
  const PuntiPage({super.key});

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
    final leaderboardAsync = ref.watch(leaderboardProvider);
    final statsAsync = ref.watch(pointsStatsProvider);
    final todaySpinAsync = ref.watch(todaySpinProvider);

    // Estrai dati con fallback per rendering progressivo
    final wallet = walletAsync.when(
      data: (w) => w,
      loading: () => null,
      error: (_, __) => null,
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

                // Squadra + Membri + Classifica
                const TeamLeaderboardCard(),
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

