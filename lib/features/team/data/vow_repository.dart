import 'package:vigilo/core/data/base_repository.dart';

/// Repository per sondaggi VOW (Voice of Worker) via Supabase RPC.
class VowRepository extends BaseRepository {
  const VowRepository(super.client);

  /// Invia sondaggio VOW. Ritorna average_rating + punti.
  Future<Map<String, dynamic>> submitSurvey({
    required Map<String, int> answers,
  }) async {
    return await rpc<Map<String, dynamic>>(
      'submit_vow_survey',
      params: {'p_answers': answers},
    );
  }
}
