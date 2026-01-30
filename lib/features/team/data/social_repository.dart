import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/team/domain/models/social_post.dart';

/// Repository per bacheca sociale via Supabase RPC.
class SocialRepository extends BaseRepository {
  const SocialRepository(super.client);

  /// Feed bacheca sociale con stato like utente.
  Future<List<SocialPost>> getSocialFeed({
    int limit = 20,
    int offset = 0,
  }) async {
    final json = await rpc<List<dynamic>>(
      'get_social_feed',
      params: {'p_limit': limit, 'p_offset': offset},
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(SocialPost.fromJson)
        .toList();
  }

  /// Metti/togli like su un post.
  Future<Map<String, dynamic>> toggleLike(String postId) async {
    return await rpc<Map<String, dynamic>>(
      'toggle_social_like',
      params: {'p_post_id': postId},
    );
  }
}
