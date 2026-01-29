import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/dual_wallet.dart';
import 'package:vigilo/features/shop/presentation/pages/shop_page.dart';
import 'package:vigilo/features/punti/domain/models/leaderboard_entry.dart';
import 'package:vigilo/features/punti/domain/models/points_stats.dart';
import 'package:vigilo/features/punti/domain/models/points_transaction.dart';
import 'package:vigilo/features/punti/domain/models/reward.dart';
import 'package:vigilo/features/punti/domain/models/wallet_type.dart';
import 'package:vigilo/features/punti/presentation/pages/rewards_catalog_sheet.dart';
import 'package:vigilo/features/punti/presentation/pages/spin_wheel_page.dart';
import 'package:vigilo/features/punti/presentation/widgets/dual_wallet_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/instant_win_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/leaderboard_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/points_stats_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/rewards_catalog_preview.dart';

/// Pagina principale Punti
class PuntiPage extends StatefulWidget {
  const PuntiPage({super.key});

  @override
  State<PuntiPage> createState() => _PuntiPageState();
}

class _PuntiPageState extends State<PuntiPage> {
  // Mock data - in produzione verrebbe da un repository/provider
  DualWallet _dualWallet = DualWallet.mockWallet();
  bool _hasSpinAvailable = true;

  int get _totalPoints => _dualWallet.puntiElmetto;

  // Mock data usando i metodi statici dei modelli
  final List<Reward> _rewards = Reward.mockRewards();
  final List<LeaderboardEntry> _leaderboard =
      LeaderboardEntry.mockLeaderboard();
  PointsStats _stats = PointsStats.mockStats();

  void _openCatalog({Reward? initialReward}) {
    unawaited(HapticFeedback.lightImpact());
    unawaited(
      RewardsCatalogSheet.show(
        context,
        rewards: _rewards,
        userPoints: _totalPoints,
        initialReward: initialReward,
      ),
    );
  }

  Future<void> _openSpinWheel() async {
    unawaited(HapticFeedback.mediumImpact());
    final wonPoints = await Navigator.of(context).push<int>(
      MaterialPageRoute<int>(
        builder: (context) => SpinWheelPage(
          hasSpinAvailable: _hasSpinAvailable,
          currentPoints: _totalPoints,
        ),
      ),
    );

    if (wonPoints != null && wonPoints > 0) {
      setState(() {
        _hasSpinAvailable = false;
        // Aggiorna dual wallet con nuovi punti e transazione
        final newTransaction = PointsTransaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          description: 'Bonus Gira la Ruota',
          amount: wonPoints,
          type: TransactionType.bonus,
          createdAt: DateTime.now(),
          walletType: WalletType.elmetto,
        );
        _dualWallet = DualWallet(
          puntiElmetto: _dualWallet.puntiElmetto + wonPoints,
          welfarePlan: _dualWallet.welfarePlan,
          elmettoTransactions: [
            newTransaction,
            ..._dualWallet.elmettoTransactions,
          ],
          welfareTransactions: _dualWallet.welfareTransactions,
        );
        // Aggiorna stats
        _stats = PointsStats(
          totalPoints: _totalPoints,
          pointsLast7Days: _stats.pointsLast7Days + wonPoints,
          pointsLast30Days: _stats.pointsLast30Days + wonPoints,
          missionsLast7Days: _stats.missionsLast7Days,
          missionsLast30Days: _stats.missionsLast30Days,
          dailyPoints: _stats.dailyPoints,
        );
      });
    } else if (wonPoints == 0) {
      setState(() {
        _hasSpinAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Simula refresh
          await Future<void>.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dual Wallet Card
              DualWalletCard(wallet: _dualWallet),
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
              RewardsCatalogPreview(
                rewards: _rewards,
                userPoints: _totalPoints,
                onRewardTap: (reward) => _openCatalog(initialReward: reward),
                onViewAllTap: _openCatalog,
              ),
              const SizedBox(height: 16),

              // Statistiche
              PointsStatsCard(stats: _stats),
              const SizedBox(height: 16),

              // Classifica
              LeaderboardCard(entries: _leaderboard),
              const SizedBox(height: 16),

              // Instant Win
              InstantWinCard(
                hasSpinAvailable: _hasSpinAvailable,
                onSpinTap: _openSpinWheel,
              ),
            ],
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
