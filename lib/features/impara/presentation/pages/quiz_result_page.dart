import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/impara/domain/models/quiz.dart';
import 'package:vigilo/shared/widgets/points_earned_snackbar.dart';

/// Pagina risultato quiz
class QuizResultPage extends StatelessWidget {
  const QuizResultPage({
    required this.quiz,
    required this.result,
    super.key,
  });

  final Quiz quiz;
  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Show points feedback after frame renders
    if (result.earnedPoints > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          PointsEarnedSnackbar.show(
            context,
            points: result.earnedPoints,
            action: 'Quiz completato',
          );
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Icona risultato
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: result.resultColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  result.passed
                      ? Icons.emoji_events_rounded
                      : Icons.sentiment_dissatisfied_rounded,
                  size: 64,
                  color: result.resultColor,
                ),
              ),
              const SizedBox(height: 24),

              // Titolo
              Text(
                result.passed ? 'QUIZ COMPLETATO ✓' : 'QUIZ NON SUPERATO',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: result.resultColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                result.resultLabel,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 32),

              // Statistiche
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.white,
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
                  children: [
                    // Percentuale
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${result.percentage}',
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                            color: result.resultColor,
                            height: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: result.resultColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Dettagli
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(
                          label: 'Corrette',
                          value: '${result.correctAnswers}',
                          color: AppTheme.secondary,
                          isDark: isDark,
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: isDark ? Colors.white12 : Colors.black12,
                        ),
                        _StatItem(
                          label: 'Totali',
                          value: '${result.totalQuestions}',
                          color: AppTheme.tertiary,
                          isDark: isDark,
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: isDark ? Colors.white12 : Colors.black12,
                        ),
                        _StatItem(
                          label: 'Punti',
                          value: '+${result.earnedPoints}',
                          color: AppTheme.primary,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Suggerimenti
              if (!result.passed) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppTheme.warning.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            color: AppTheme.warning,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Suggerimenti',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.warning,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '• Rivedi il modulo "DPI Base"\n'
                        '• Guarda il video "Uso sicuro del casco"\n'
                        '• Riprova domani',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Bottoni
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        // TODO: mostra risposte
                      },
                      icon: const Icon(Icons.visibility_rounded, size: 20),
                      label: const Text('Vedi risposte'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Navigator.of(context).popUntil(
                          (route) => route.isFirst,
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: result.passed
                            ? AppTheme.secondary
                            : AppTheme.tertiary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Torna a Impara',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Link punti
              if (result.earnedPoints > 0)
                TextButton.icon(
                  onPressed: () {
                    // TODO: vai a punti
                  },
                  icon: Icon(
                    Icons.stars_rounded,
                    color: AppTheme.primary,
                    size: 20,
                  ),
                  label: Text(
                    'Vai ai Punti',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w600,
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

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  final String label;
  final String value;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white54 : Colors.black45,
          ),
        ),
      ],
    );
  }
}
