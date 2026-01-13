import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/impara/domain/models/training_content.dart';

/// Bottom sheet dettaglio contenuto formativo
class ContentDetailSheet extends StatefulWidget {
  const ContentDetailSheet({
    required this.content,
    super.key,
  });

  final TrainingContent content;

  static Future<void> show(
    BuildContext context, {
    required TrainingContent content,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContentDetailSheet(content: content),
    );
  }

  @override
  State<ContentDetailSheet> createState() => _ContentDetailSheetState();
}

class _ContentDetailSheetState extends State<ContentDetailSheet> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.content.isFavorite;
  }

  void _toggleFavorite() {
    HapticFeedback.lightImpact();
    setState(() => _isFavorite = !_isFavorite);
  }

  void _startContent() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop();
    // In produzione: naviga al video player o apri PDF
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Apertura ${widget.content.type.label}...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final content = widget.content;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Contenuto scrollabile
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header con tipo e chiudi
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: content.type.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  content.type.icon,
                                  size: 16,
                                  color: content.type.color,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  content.type.label,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: content.type.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (content.isMandatory) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.danger.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Obbligatorio',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.danger,
                                ),
                              ),
                            ),
                          ],
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.close_rounded,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Titolo
                      Text(
                        content.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Info riga
                      Row(
                        children: [
                          Icon(
                            content.category.icon,
                            size: 16,
                            color: isDark ? Colors.white54 : Colors.black45,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            content.category.label,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.schedule_rounded,
                            size: 16,
                            color: isDark ? Colors.white54 : Colors.black45,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            content.durationLabel,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                          if (content.points > 0) ...[
                            const SizedBox(width: 16),
                            Icon(
                              Icons.bolt_rounded,
                              size: 16,
                              color: AppTheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '+${content.points} pt',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Stato
                      if (content.status != ContentStatus.notStarted) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: content.status.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  content.status.color.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                content.status == ContentStatus.completed
                                    ? Icons.check_circle_rounded
                                    : Icons.play_circle_rounded,
                                color: content.status.color,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stato: ${content.status.label}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: content.status.color,
                                      ),
                                    ),
                                    if (content.status ==
                                        ContentStatus.inProgress) ...[
                                      const SizedBox(height: 6),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: content.progress,
                                          backgroundColor: isDark
                                              ? Colors.white.withValues(
                                                  alpha: 0.1)
                                              : Colors.black.withValues(
                                                  alpha: 0.1),
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            content.status.color,
                                          ),
                                          minHeight: 6,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${(content.progress * 100).round()}% completato',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isDark
                                              ? Colors.white54
                                              : Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Descrizione
                      Text(
                        'Descrizione',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        content.description,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Bottoni azione
                      Row(
                        children: [
                          // Preferiti
                          OutlinedButton.icon(
                            onPressed: _toggleFavorite,
                            icon: Icon(
                              _isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 20,
                            ),
                            label: Text(
                                _isFavorite ? 'Salvato' : 'Salva'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _isFavorite
                                  ? AppTheme.danger
                                  : (isDark ? Colors.white70 : Colors.black54),
                              side: BorderSide(
                                color: _isFavorite
                                    ? AppTheme.danger.withValues(alpha: 0.5)
                                    : (isDark
                                        ? Colors.white24
                                        : Colors.black26),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Avvia
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: _startContent,
                              icon: Icon(
                                content.type == ContentType.video
                                    ? Icons.play_arrow_rounded
                                    : Icons.open_in_new_rounded,
                                size: 20,
                              ),
                              label: Text(
                                content.status == ContentStatus.inProgress
                                    ? 'Continua'
                                    : content.type == ContentType.video
                                        ? 'Guarda Video'
                                        : content.type == ContentType.pdf
                                            ? 'Apri PDF'
                                            : 'Inizia',
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: content.type.color,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
