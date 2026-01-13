import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/impara/domain/models/training_content.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

/// Card preview Biblioteca con ricerca e contenuti suggeriti
class LibraryPreviewCard extends StatelessWidget {
  const LibraryPreviewCard({
    required this.suggestedContents,
    this.onSearchTap,
    this.onContentTap,
    this.onViewAllTap,
    super.key,
  });

  final List<TrainingContent> suggestedContents;
  final VoidCallback? onSearchTap;
  final void Function(TrainingContent)? onContentTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
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
                  Icons.local_library_rounded,
                  color: AppTheme.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.imparaLibrary,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Barra ricerca
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: isDark ? Colors.white54 : Colors.black45,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l10n.imparaSearchContents,
                    style: TextStyle(
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Categorie rapide
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ContentCategory.values.take(4).map((cat) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        cat.icon,
                        size: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        cat.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Contenuti suggeriti
          Text(
            l10n.imparaSuggestedContents,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          ...suggestedContents.take(3).map(
                (content) => _ContentPreviewTile(
                  content: content,
                  isDark: isDark,
                  onTap: () => onContentTap?.call(content),
                ),
              ),

          // Vedi tutto
          if (onViewAllTap != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onViewAllTap?.call();
                },
                icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                label: Text(l10n.imparaViewAllLibrary),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.secondary,
                  side: BorderSide(
                    color: AppTheme.secondary.withValues(alpha: 0.5),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ContentPreviewTile extends StatelessWidget {
  const _ContentPreviewTile({
    required this.content,
    required this.isDark,
    this.onTap,
  });

  final TrainingContent content;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: content.type.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                content.type.icon,
                color: content.type.color,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${content.type.label} • ${content.durationLabel}',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark ? Colors.white38 : Colors.black26,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
