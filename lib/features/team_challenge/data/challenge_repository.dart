import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/team_challenge/domain/models/challenge.dart';

/// Repository per sfide team via Supabase RPC.
class ChallengeRepository extends BaseRepository {
  const ChallengeRepository(super.client);

  /// Sfida attiva corrente con contributi.
  Future<Challenge?> getActiveChallenge() async {
    final json = await rpc<Map<String, dynamic>?>('get_active_challenge');
    if (json == null) return null;
    return Challenge.fromJson(json);
  }

  /// Storico sfide completate.
  Future<List<Challenge>> getChallengeHistory({int limit = 10}) async {
    final json = await rpc<List<dynamic>>(
      'get_challenge_history',
      params: {'p_limit': limit},
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(Challenge.fromJson)
        .toList();
  }
}
