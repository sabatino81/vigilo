import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/punti/domain/models/leaderboard_entry.dart';

/// Repository per la classifica aziendale.
class LeaderboardRepository extends BaseRepository {
  const LeaderboardRepository(super.client);

  /// Classifica utenti della stessa azienda.
  Future<List<LeaderboardEntry>> getLeaderboard({int limit = 10}) async {
    final json = await rpc<List<dynamic>>(
      'get_leaderboard',
      params: {'p_limit': limit},
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(LeaderboardEntry.fromJson)
        .toList();
  }
}
