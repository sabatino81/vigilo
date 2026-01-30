import 'package:test/test.dart';
import 'package:vigilo/features/team/domain/models/social_post.dart';

void main() {
  group('SocialPost.fromJson', () {
    test('parses complete JSON', () {
      final json = {
        'id': 'post_1',
        'image_url': 'https://img.com/photo.jpg',
        'thumbnail_url': 'https://img.com/thumb.jpg',
        'caption': 'Great day!',
        'author_name': 'Marco',
        'likes_count': 24,
        'comments_count': 5,
        'aspect_ratio': 1.5,
        'created_at': '2025-01-15T10:00:00Z',
        'liked_by_me': true,
      };

      final post = SocialPost.fromJson(json);
      expect(post.id, 'post_1');
      expect(post.imagePath, 'https://img.com/photo.jpg');
      expect(post.thumbnailPath, 'https://img.com/thumb.jpg');
      expect(post.caption, 'Great day!');
      expect(post.author, 'Marco');
      expect(post.likes, 24);
      expect(post.comments, 5);
      expect(post.aspectRatio, 1.5);
      expect(post.likedByMe, isTrue);
    });

    test('defaults missing fields', () {
      final json = {
        'id': 'post_2',
      };

      final post = SocialPost.fromJson(json);
      expect(post.imagePath, '');
      expect(post.thumbnailPath, isNull);
      expect(post.caption, '');
      expect(post.author, '');
      expect(post.likes, 0);
      expect(post.comments, 0);
      expect(post.aspectRatio, 1.0);
      expect(post.likedByMe, isFalse);
    });
  });

  group('SocialPost.thumbPath', () {
    test('returns thumbnail when available', () {
      final post = SocialPost(
        id: 'p1',
        imagePath: 'original.jpg',
        thumbnailPath: 'thumb.jpg',
        caption: '',
        author: '',
        likes: 0,
        date: DateTime(2025, 1, 15),
      );
      expect(post.thumbPath, 'thumb.jpg');
    });

    test('returns imagePath when no thumbnail', () {
      final post = SocialPost(
        id: 'p2',
        imagePath: 'original.jpg',
        caption: '',
        author: '',
        likes: 0,
        date: DateTime(2025, 1, 15),
      );
      expect(post.thumbPath, 'original.jpg');
    });
  });
}
