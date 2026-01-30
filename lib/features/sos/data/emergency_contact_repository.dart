import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/sos/domain/models/emergency_contact.dart';

/// Repository per contatti di emergenza via Supabase RPC.
class EmergencyContactRepository extends BaseRepository {
  const EmergencyContactRepository(super.client);

  /// Contatti emergenza dell'utente e dell'azienda.
  Future<List<EmergencyContact>> getMyContacts() async {
    final json = await rpc<List<dynamic>>('get_my_emergency_contacts');
    return json
        .whereType<Map<String, dynamic>>()
        .map(EmergencyContact.fromJson)
        .toList();
  }
}
