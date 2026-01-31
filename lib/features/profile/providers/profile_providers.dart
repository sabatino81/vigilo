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
/// Se l'utente non e' collegato a un lavoratore, tenta auto-link per email.
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
      var profile = await repo.getMyProfile();

      // Se non collegato, tenta auto-link per email in background
      if (!profile.isLinked) {
        try {
          final result = await repo.autoLinkByEmail();
          if (result['linked'] == true) {
            // Ricarica il profilo con i dati del lavoratore
            profile = await repo.getMyProfile();
          }
        } on Object {
          // Auto-link fallito silenziosamente, non bloccare il caricamento
        }
      }

      return profile;
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

  /// Collega manualmente l'utente a un lavoratore e ricarica il profilo.
  Future<void> linkWorker(String lavoratoreId) async {
    final repo = ref.read(profileRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.linkWorkerProfile(lavoratoreId);
      return repo.getMyProfile();
    });
  }

  /// Tenta il collegamento automatico per email e ricarica il profilo.
  Future<void> autoLink() async {
    final repo = ref.read(profileRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await repo.autoLinkByEmail();
      if (result['linked'] == true) {
        return repo.getMyProfile();
      }
      // Se non collegato, ritorna il profilo attuale senza errore
      return repo.getMyProfile();
    });
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
