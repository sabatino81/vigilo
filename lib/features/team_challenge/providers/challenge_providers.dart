import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/team_challenge/data/challenge_repository.dart';
import 'package:vigilo/features/team_challenge/domain/models/challenge.dart';

// ============================================================
// Repository provider
// ============================================================

final challengeRepositoryProvider = Provider<ChallengeRepository>((ref) {
  return ChallengeRepository(ref.watch(supabaseClientProvider));
});

// ============================================================
// Active challenge provider
// ============================================================

final activeChallengeProvider =
    AsyncNotifierProvider<ActiveChallengeNotifier, Challenge?>(
  ActiveChallengeNotifier.new,
);

class ActiveChallengeNotifier extends AsyncNotifier<Challenge?> {
  @override
  Future<Challenge?> build() async {
    try {
      final repo = ref.read(challengeRepositoryProvider);
      return await repo.getActiveChallenge();
    } on Object {
      return Challenge.mockChallenge();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(challengeRepositoryProvider);
      return repo.getActiveChallenge();
    });
  }
}

// ============================================================
// Challenge history provider
// ============================================================

final challengeHistoryProvider =
    AsyncNotifierProvider<ChallengeHistoryNotifier, List<Challenge>>(
  ChallengeHistoryNotifier.new,
);

class ChallengeHistoryNotifier extends AsyncNotifier<List<Challenge>> {
  @override
  Future<List<Challenge>> build() async {
    try {
      final repo = ref.read(challengeRepositoryProvider);
      return await repo.getChallengeHistory();
    } on Object {
      return Challenge.mockHistory();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(challengeRepositoryProvider);
      return repo.getChallengeHistory();
    });
  }
}
