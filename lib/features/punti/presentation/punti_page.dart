import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/features/punti/domain/models/leaderboard_entry.dart';
import 'package:vigilo/features/punti/domain/models/points_stats.dart';
import 'package:vigilo/features/punti/domain/models/points_transaction.dart';
import 'package:vigilo/features/punti/domain/models/reward.dart';
import 'package:vigilo/features/punti/presentation/pages/rewards_catalog_sheet.dart';
import 'package:vigilo/features/punti/presentation/pages/spin_wheel_page.dart';
import 'package:vigilo/features/punti/presentation/widgets/instant_win_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/leaderboard_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/points_stats_card.dart';
import 'package:vigilo/features/punti/presentation/widgets/rewards_catalog_preview.dart';
import 'package:vigilo/features/punti/presentation/widgets/wallet_card.dart';

/// Pagina principale Punti
class PuntiPage extends StatefulWidget {
  const PuntiPage({super.key});

  @override
  State<PuntiPage> createState() => _PuntiPageState();
}

class _PuntiPageState extends State<PuntiPage> {
  // Mock data - in produzione verrebbe da un repository/provider
  int _totalPoints = 1320;
  bool _hasSpinAvailable = true;

  // Mock data usando i metodi statici dei modelli
  List<PointsTransaction> _transactions = PointsTransaction.mockTransactions();
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
        _totalPoints += wonPoints;
        _hasSpinAvailable = false;
        // Aggiungi transazione
        _transactions = [
          PointsTransaction(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            description: 'Bonus Gira la Ruota',
            amount: wonPoints,
            type: TransactionType.bonus,
            createdAt: DateTime.now(),
          ),
          ..._transactions,
        ];
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
              // Wallet Card
              WalletCard(
                totalPoints: _totalPoints,
                transactions: _transactions,
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
