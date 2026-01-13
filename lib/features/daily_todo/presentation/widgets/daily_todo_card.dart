import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class DailyTodoCard extends StatelessWidget {
  const DailyTodoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final todoItems = [
      {
        'title': l10n?.weeklyQuiz ?? 'Quiz settimanale',
        'points': 20,
        'action': l10n?.actionStart ?? 'Inizia',
        'icon': Icons.quiz_rounded,
        'color': AppTheme.tertiary,
      },
      {
        'title': l10n?.safetySurvey ?? 'Survey sicurezza',
        'points': 50,
        'action': l10n?.actionAnswer ?? 'Rispondi',
        'icon': Icons.assignment_rounded,
        'color': AppTheme.secondary,
      },
      {
        'title': l10n?.safetyReport ?? 'Segnalazione sicurezza',
        'points': 30,
        'action': l10n?.actionSos ?? 'SOS',
        'icon': Icons.report_problem_rounded,
        'color': AppTheme.danger,
      },
      {
        'title': l10n?.microTraining ?? 'Micro-formazione 5\'',
        'points': 10,
        'action': l10n?.actionWatch ?? 'Guarda',
        'icon': Icons.play_circle_rounded,
        'color': AppTheme.warning,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2A2A2A)
            : Colors.white,
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
                  color: AppTheme.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.checklist_rounded,
                  color: AppTheme.warning,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.dailyTodo ?? 'TO-DO DEL GIORNO',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Todo items
          ...todoItems.map((item) => _buildTodoItem(
                context,
                item['title'] as String,
                item['points'] as int,
                item['action'] as String,
                item['icon'] as IconData,
                item['color'] as Color,
                isDark,
              )),
        ],
      ),
    );
  }

  Widget _buildTodoItem(
    BuildContext context,
    String title,
    int points,
    String action,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Title and points
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppTheme.primary,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+$points pt',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action button
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            style: TextButton.styleFrom(
              foregroundColor: color,
              backgroundColor: color.withValues(alpha: 0.1),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
