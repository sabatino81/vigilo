import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/team/domain/models/social_post.dart';
import 'package:vigilo/features/team/presentation/pages/social_wall_page.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class SocialWallCard extends StatelessWidget {
  const SocialWallCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Hero(
      tag: 'social_wall_hero',
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.photo_library_rounded,
                      color: AppTheme.secondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n?.socialWallTitle ?? 'BACHECA',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Griglia Pinterest con post clickabili
              _PinterestMiniGrid(isDark: isDark),

              const SizedBox(height: 12),

              // Bottone per vedere tutti i post
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const SocialWallPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.grid_view_rounded, size: 16),
                  label: Text(
                    l10n?.viewAllPosts ?? 'Vedi altri post',
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.secondary,
                    side: BorderSide(
                      color: AppTheme.secondary.withValues(alpha: 0.4),
                      width: 1,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Griglia Pinterest compatta con 2 colonne - mostra solo 4 post
class _PinterestMiniGrid extends StatelessWidget {
  const _PinterestMiniGrid({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    // Mostra solo i primi 4 post per evitare scroll
    final posts = SocialPost.staticPosts.take(4).toList();

    // Dividi i post in due colonne
    final leftColumn = <SocialPost>[];
    final rightColumn = <SocialPost>[];

    for (var i = 0; i < posts.length; i++) {
      if (i % 2 == 0) {
        leftColumn.add(posts[i]);
      } else {
        rightColumn.add(posts[i]);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: leftColumn.map((post) {
              return _MiniPostCard(
                post: post,
                isDark: isDark,
                onTap: () => _showPostDetail(context, post),
              );
            }).toList(),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: rightColumn.map((post) {
              return _MiniPostCard(
                post: post,
                isDark: isDark,
                onTap: () => _showPostDetail(context, post),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showPostDetail(BuildContext context, SocialPost post) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PostDetailPage(post: post),
      ),
    );
  }
}

/// Mini card per post nella bacheca - versione compatta
class _MiniPostCard extends StatelessWidget {
  const _MiniPostCard({
    required this.post,
    required this.isDark,
    required this.onTap,
  });

  final SocialPost post;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Immagine con proporzioni reali ridotte
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: AspectRatio(
                aspectRatio: post.aspectRatio,
                child: Image.asset(
                  post.thumbPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: isDark ? Colors.grey[800] : Colors.grey[300],
                      child: const Icon(
                        Icons.construction,
                        color: Colors.grey,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Informazioni ultra compatte
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Caption ridotta
                  Text(
                    post.caption,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Likes e commenti mini
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 10,
                        color: Colors.red[400],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${post.likes}',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.7)
                              : Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.chat_bubble,
                        size: 10,
                        color: Colors.blue[400],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${post.comments}',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.7)
                              : Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
