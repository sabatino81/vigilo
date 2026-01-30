import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/team/domain/models/social_post.dart';
import 'package:vigilo/features/team/providers/team_providers.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

/// Pagina che mostra tutti i post della bacheca sociale — ConsumerWidget.
class SocialWallPage extends ConsumerWidget {
  const SocialWallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final feedAsync = ref.watch(socialFeedProvider);

    final posts = feedAsync.when(
      data: (p) => p,
      loading: () => <SocialPost>[],
      error: (_, __) => <SocialPost>[],
    );

    return Hero(
      tag: 'social_wall_hero',
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.grey[50],
        appBar: AppBar(
          title: Text(
            l10n?.socialWallTitle ?? 'BACHECA',
            style: theme.textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_photo_alternate_rounded),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n?.createPost ?? 'Crea un post'),
                  ),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(socialFeedProvider);
          },
          child: _PinterestGrid(isDark: isDark, posts: posts),
        ),
      ),
    );
  }
}

/// Griglia in stile Pinterest con due colonne e proporzioni reali
class _PinterestGrid extends StatefulWidget {
  const _PinterestGrid({required this.isDark, required this.posts});

  final bool isDark;
  final List<SocialPost> posts;

  @override
  State<_PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<_PinterestGrid> {
  final _scrollController = ScrollController();
  List<SocialPost> _displayedPosts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant _PinterestGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.posts != widget.posts) {
      _loadPosts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadPosts() {
    // Duplica i post per creare un feed più lungo
    final allPosts = <SocialPost>[];
    for (var i = 0; i < 5; i++) {
      allPosts.addAll(widget.posts);
    }
    setState(() {
      _displayedPosts = allPosts;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      setState(() {
        _displayedPosts.addAll(widget.posts);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final leftColumn = <SocialPost>[];
    final rightColumn = <SocialPost>[];

    for (var i = 0; i < _displayedPosts.length; i++) {
      if (i % 2 == 0) {
        leftColumn.add(_displayedPosts[i]);
      } else {
        rightColumn.add(_displayedPosts[i]);
      }
    }

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: leftColumn.map((post) {
                return _PinterestPostCard(
                  post: post,
                  isDark: widget.isDark,
                  onTap: () => _showPostDetail(context, post),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: rightColumn.map((post) {
                return _PinterestPostCard(
                  post: post,
                  isDark: widget.isDark,
                  onTap: () => _showPostDetail(context, post),
                );
              }).toList(),
            ),
          ),
        ],
      ),
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

/// Card singola in stile Pinterest con proporzioni reali
class _PinterestPostCard extends StatelessWidget {
  const _PinterestPostCard({
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
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Immagine con proporzioni reali
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
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
                      ),
                    );
                  },
                ),
              ),
            ),

            // Informazioni post
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Caption
                  Text(
                    post.caption,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Autore
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppTheme.primary,
                        child: Text(
                          post.author[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          post.author,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.8)
                                : Colors.black.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Likes e commenti
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        size: 16,
                        color: Colors.red[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post.likes}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.7)
                              : Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.chat_bubble_rounded,
                        size: 16,
                        color: Colors.blue[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post.comments}',
                        style: TextStyle(
                          fontSize: 12,
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

/// Pagina dettaglio post con immagine ad alta risoluzione
class PostDetailPage extends StatelessWidget {
  const PostDetailPage({
    required this.post,
    super.key,
  });

  final SocialPost post;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy • HH:mm', 'it');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con autore
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.primary,
                    child: Text(
                      post.author[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.author,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          dateFormat.format(post.date),
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.6)
                                : Colors.black.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Immagine ad alta risoluzione con proporzioni reali
            AspectRatio(
              aspectRatio: post.aspectRatio,
              child: Image.asset(
                post.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: isDark ? Colors.grey[900] : Colors.grey[200],
                    child: const Center(
                      child: Icon(
                        Icons.construction,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Interazioni (likes, commenti)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _ActionButton(
                    icon: Icons.favorite_rounded,
                    color: Colors.red[400]!,
                    count: post.likes,
                    label: 'Mi piace',
                  ),
                  const SizedBox(width: 24),
                  _ActionButton(
                    icon: Icons.chat_bubble_rounded,
                    color: Colors.blue[400]!,
                    count: post.comments,
                    label: 'Commenti',
                  ),
                  const SizedBox(width: 24),
                  _ActionButton(
                    icon: Icons.share_rounded,
                    color: Colors.green[400]!,
                    count: 0,
                    label: 'Condividi',
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Caption
            Padding(
              padding: const EdgeInsets.all(16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '${post.author} ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: post.caption),
                  ],
                ),
              ),
            ),

            const Divider(height: 1),

            // Sezione commenti (placeholder)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Commenti',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Nessun commento ancora',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.5)
                            : Colors.black.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pulsante di azione (like, commento, condividi)
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.count,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        if (count > 0)
          Text(
            '$count',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
      ],
    );
  }
}
