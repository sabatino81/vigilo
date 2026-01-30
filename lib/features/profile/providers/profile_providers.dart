import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/profile/data/profile_repository.dart';
import 'package:vigilo/features/profile/domain/models/user_profile.dart';

/// Provider per [ProfileRepository].
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(supabaseClientProvider));
});

/// Provider asincrono per il profilo utente corrente.
///
/// Carica il profilo da Supabase al primo accesso.
/// In caso di errore, ritorna il profilo mock come fallback.
final profileProvider =
    AsyncNotifierProvider<ProfileNotifier, UserProfile>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    try {
      final repo = ref.read(profileRepositoryProvider);
      return await repo.getMyProfile();
    } on Object {
      // Fallback a mock per dev/test offline
      return UserProfile.mockProfile();
    }
  }

  /// Aggiorna il profilo e ricarica lo stato.
  Future<void> updateProfile({
    String? name,
    WorkerCategory? category,
    String? avatarUrl,
  }) async {
    final repo = ref.read(profileRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => repo.updateMyProfile(
        name: name,
        category: category,
        avatarUrl: avatarUrl,
      ),
    );
  }

  /// Forza il ricaricamento del profilo dal server.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      return repo.getMyProfile();
    });
  }
}
