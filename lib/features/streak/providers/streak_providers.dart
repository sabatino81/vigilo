import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/streak/data/streak_repository.dart';
import 'package:vigilo/features/streak/domain/models/streak.dart';

/// Repository provider.
final streakRepositoryProvider = Provider<StreakRepository>((ref) {
  return StreakRepository(ref.watch(supabaseClientProvider));
});

/// Provider asincrono per i dati streak dell'utente.
final streakProvider =
    AsyncNotifierProvider<StreakNotifier, Streak>(
  StreakNotifier.new,
);

class StreakNotifier extends AsyncNotifier<Streak> {
  @override
  Future<Streak> build() async {
    try {
      final repo = ref.read(streakRepositoryProvider);
      return await repo.getMyStreak();
    } on Object {
      return Streak.mockStreak();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(streakRepositoryProvider);
      return repo.getMyStreak();
    });
  }
}
