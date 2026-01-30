import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/streak/domain/models/streak.dart';

/// Repository per dati streak via Supabase RPC.
class StreakRepository extends BaseRepository {
  const StreakRepository(super.client);

  /// Dati streak + calendario mese corrente.
  Future<Streak> getMyStreak() async {
    final json = await rpc<Map<String, dynamic>>('get_my_streak');
    return Streak.fromJson(json);
  }
}
