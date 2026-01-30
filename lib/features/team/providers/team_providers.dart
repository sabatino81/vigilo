import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/team/data/social_repository.dart';
import 'package:vigilo/features/team/data/vow_repository.dart';
import 'package:vigilo/features/team/domain/models/social_post.dart';

// ============================================================
// Repository providers
// ============================================================

final socialRepositoryProvider = Provider<SocialRepository>((ref) {
  return SocialRepository(ref.watch(supabaseClientProvider));
});

final vowRepositoryProvider = Provider<VowRepository>((ref) {
  return VowRepository(ref.watch(supabaseClientProvider));
});

// ============================================================
// Social feed provider
// ============================================================

final socialFeedProvider =
    AsyncNotifierProvider<SocialFeedNotifier, List<SocialPost>>(
  SocialFeedNotifier.new,
);

class SocialFeedNotifier extends AsyncNotifier<List<SocialPost>> {
  @override
  Future<List<SocialPost>> build() async {
    try {
      final repo = ref.read(socialRepositoryProvider);
      return await repo.getSocialFeed();
    } on Object {
      return SocialPost.staticPosts;
    }
  }

  /// Toggle like su un post.
  Future<void> toggleLike(String postId) async {
    try {
      final repo = ref.read(socialRepositoryProvider);
      await repo.toggleLike(postId);
      ref.invalidateSelf();
      await future;
    } on Object {
      // ignore
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(socialRepositoryProvider);
      return repo.getSocialFeed();
    });
  }
}
