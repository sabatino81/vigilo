import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/punti/data/leaderboard_repository.dart';
import 'package:vigilo/features/punti/data/wallet_repository.dart';
import 'package:vigilo/features/punti/domain/models/elmetto_wallet.dart';
import 'package:vigilo/features/punti/domain/models/leaderboard_entry.dart';
import 'package:vigilo/features/punti/domain/models/points_stats.dart';
import 'package:vigilo/features/punti/domain/models/reward.dart';
import 'package:vigilo/features/punti/domain/models/wheel_prize.dart';

// ============================================================
// Repository providers
// ============================================================

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository(ref.watch(supabaseClientProvider));
});

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository(ref.watch(supabaseClientProvider));
});

// ============================================================
// Wallet provider (saldo + transazioni recenti)
// ============================================================

final walletProvider =
    AsyncNotifierProvider<WalletNotifier, ElmettoWallet>(
  WalletNotifier.new,
);

class WalletNotifier extends AsyncNotifier<ElmettoWallet> {
  @override
  Future<ElmettoWallet> build() async {
    try {
      final repo = ref.read(walletRepositoryProvider);
      return await repo.getMyWallet();
    } on Object {
      return ElmettoWallet.mockWallet();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(walletRepositoryProvider);
      return repo.getMyWallet();
    });
  }
}

// ============================================================
// Points stats provider (statistiche 7gg/30gg)
// ============================================================

final pointsStatsProvider =
    AsyncNotifierProvider<PointsStatsNotifier, PointsStats>(
  PointsStatsNotifier.new,
);

class PointsStatsNotifier extends AsyncNotifier<PointsStats> {
  @override
  Future<PointsStats> build() async {
    try {
      final repo = ref.read(walletRepositoryProvider);
      return await repo.getMyPointsStats();
    } on Object {
      return PointsStats.mockStats();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(walletRepositoryProvider);
      return repo.getMyPointsStats();
    });
  }
}

// ============================================================
// Leaderboard provider
// ============================================================

final leaderboardProvider =
    AsyncNotifierProvider<LeaderboardNotifier, List<LeaderboardEntry>>(
  LeaderboardNotifier.new,
);

class LeaderboardNotifier extends AsyncNotifier<List<LeaderboardEntry>> {
  @override
  Future<List<LeaderboardEntry>> build() async {
    try {
      final repo = ref.read(leaderboardRepositoryProvider);
      return await repo.getLeaderboard();
    } on Object {
      return LeaderboardEntry.mockLeaderboard();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(leaderboardRepositoryProvider);
      return repo.getLeaderboard();
    });
  }
}

// ============================================================
// Rewards provider (catalogo premi)
// ============================================================

final rewardsProvider =
    AsyncNotifierProvider<RewardsNotifier, List<Reward>>(
  RewardsNotifier.new,
);

class RewardsNotifier extends AsyncNotifier<List<Reward>> {
  @override
  Future<List<Reward>> build() async {
    try {
      final repo = ref.read(walletRepositoryProvider);
      return await repo.getRewards();
    } on Object {
      return Reward.mockRewards();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(walletRepositoryProvider);
      return repo.getRewards();
    });
  }
}

// ============================================================
// Wheel prizes provider (configurazione ruota)
// ============================================================

final wheelPrizesProvider =
    AsyncNotifierProvider<WheelPrizesNotifier, List<WheelPrize>>(
  WheelPrizesNotifier.new,
);

class WheelPrizesNotifier extends AsyncNotifier<List<WheelPrize>> {
  @override
  Future<List<WheelPrize>> build() async {
    try {
      final repo = ref.read(walletRepositoryProvider);
      return await repo.getWheelPrizes();
    } on Object {
      return WheelPrize.standardPrizes();
    }
  }
}

// ============================================================
// Today spin status provider
// ============================================================

final todaySpinProvider =
    AsyncNotifierProvider<TodaySpinNotifier, bool>(
  TodaySpinNotifier.new,
);

/// `true` se l'utente ha già girato oggi.
class TodaySpinNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    try {
      final repo = ref.read(walletRepositoryProvider);
      final result = await repo.getTodaySpin();
      return result['has_spun'] as bool? ?? false;
    } on Object {
      return false;
    }
  }

  void markAsSpun() {
    state = const AsyncValue.data(true);
  }
}
