import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/profile/domain/models/user_profile.dart';

/// Repository per operazioni profilo utente via Supabase RPC.
class ProfileRepository extends BaseRepository {
  const ProfileRepository(super.client);

  /// Carica il profilo dell'utente corrente.
  ///
  /// Chiama la RPC `get_my_profile()` che ritorna il profilo
  /// associato all'utente autenticato (auth.uid()).
  Future<UserProfile> getMyProfile() async {
    final json = await rpc<Map<String, dynamic>>('get_my_profile');
    return UserProfile.fromJson(json);
  }

  /// Aggiorna il profilo dell'utente corrente.
  ///
  /// Chiama la RPC `update_my_profile()` con i campi modificabili.
  /// Ritorna il profilo aggiornato.
  Future<UserProfile> updateMyProfile({
    String? name,
    WorkerCategory? category,
    String? avatarUrl,
  }) async {
    final json = await rpc<Map<String, dynamic>>(
      'update_my_profile',
      params: {
        'p_name': name,
        'p_category': category?.name,
        'p_avatar_url': avatarUrl,
      },
    );
    return UserProfile.fromJson(json);
  }

  /// Collega l'utente corrente a un record lavoratore.
  Future<Map<String, dynamic>> linkWorkerProfile(String lavoratoreId) async {
    return await rpc<Map<String, dynamic>>(
      'link_worker_profile',
      params: {'p_lavoratore_id': lavoratoreId},
    );
  }

  /// Tenta il collegamento automatico per email.
  ///
  /// Ritorna `{ linked: true/false, reason?: string }`.
  Future<Map<String, dynamic>> autoLinkByEmail() async {
    return await rpc<Map<String, dynamic>>('auto_link_by_email');
  }
}
