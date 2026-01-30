import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/providers/wallet_providers.dart';
import 'package:vigilo/features/shop/presentation/pages/shop_page.dart';
import 'package:vigilo/features/punti/presentation/pages/spin_wheel_page.dart';
import 'package:vigilo/features/punti/presentation/widgets/elmetto_wallet_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/instant_win_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/leaderboard_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/points_stats_card.dart';

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

                // Come guadagnare punti
                const _HowToEarnCard(),
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

class _HowToEarnCard extends StatelessWidget {
  const _HowToEarnCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white54 : Colors.black45;
    final chipBg = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.04);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events_rounded,
                color: AppTheme.primary,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'Come guadagni Punti Elmetto',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Individuali
          Text(
            'AZIONI INDIVIDUALI',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.tertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          _earnRow(Icons.wb_sunny_rounded, 'Check-in benessere',
              '+5 pt/giorno', chipBg, titleColor, subtitleColor),
          _earnRow(Icons.rate_review_rounded, 'Feedback fine turno',
              '+10 pt/giorno', chipBg, titleColor, subtitleColor),
          _earnRow(Icons.warning_amber_rounded, 'Segnalazione rischio',
              '+30-50 pt', chipBg, titleColor, subtitleColor),
          _earnRow(Icons.star_rounded, 'Nomina Safety Star',
              '+15 pt (tu) +25 pt (collega)', chipBg, titleColor, subtitleColor),
          _earnRow(Icons.local_fire_department_rounded, 'Streak giornaliero',
              '+5-25 pt/giorno', chipBg, titleColor, subtitleColor),

          const SizedBox(height: 14),

          // Squadra
          Text(
            'AZIONI DI SQUADRA',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.secondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          _earnRow(Icons.groups_rounded, 'Sfida team completata',
              '+50-100 pt/membro', chipBg, titleColor, subtitleColor),
          _earnRow(Icons.forum_rounded, 'Post e commenti social',
              '+3-5 pt (max 30/giorno)', chipBg, titleColor, subtitleColor),

          const SizedBox(height: 14),

          // Formazione
          Text(
            'FORMAZIONE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.warning,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          _earnRow(Icons.play_circle_rounded, 'Micro-training giornaliero',
              '+15 pt/giorno', chipBg, titleColor, subtitleColor),
          _earnRow(Icons.quiz_rounded, 'Quiz settimanale',
              '+20 pt (+10 bonus se >80%)', chipBg, titleColor, subtitleColor),
          _earnRow(Icons.school_rounded, 'Completamento corso',
              '+30-80 pt', chipBg, titleColor, subtitleColor),

          const SizedBox(height: 12),
          Text(
            '60 Punti Elmetto = 1 EUR di sconto nello Spaccio',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _earnRow(
    IconData icon,
    String label,
    String points,
    Color chipBg,
    Color titleColor,
    Color subtitleColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: subtitleColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: titleColor,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              points,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
