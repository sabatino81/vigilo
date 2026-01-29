import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/team/domain/models/vow_survey.dart';
import 'package:vigilo/shared/widgets/points_earned_snackbar.dart';

/// Pagina survey VOW (Voice of Worker) — 5 domande, scala 1-5
class VowSurveyPage extends StatefulWidget {
  const VowSurveyPage({super.key});

  @override
  State<VowSurveyPage> createState() => _VowSurveyPageState();
}

class _VowSurveyPageState extends State<VowSurveyPage> {
  final _questions = VowQuestion.mockQuestions();
  final Map<String, VowAnswer> _answers = {};
  int _currentIndex = 0;
  bool _submitted = false;

  int get _answeredCount => _answers.length;
  bool get _isCurrentAnswered =>
      _answers.containsKey(_questions[_currentIndex].id);
  bool get _isComplete => _answeredCount == _questions.length;

  void _selectRating(int rating) {
    HapticFeedback.lightImpact();
    final q = _questions[_currentIndex];
    setState(() {
      _answers[q.id] = VowAnswer(questionId: q.id, rating: rating);
    });
  }

  void _next() {
    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _prev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  void _submit() {
    if (!_isComplete) return;
    HapticFeedback.mediumImpact();
    setState(() => _submitted = true);
    PointsEarnedSnackbar.show(
      context,
      points: 20,
      action: 'Sondaggio VOW',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voice of Worker',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: _submitted ? _buildResult(isDark) : _buildSurvey(isDark),
    );
  }

  Widget _buildSurvey(bool isDark) {
    final q = _questions[_currentIndex];
    final currentAnswer = _answers[q.id];

    return Column(
      children: [
        // Progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: List.generate(_questions.length, (i) {
              final isAnswered = _answers.containsKey(_questions[i].id);
              final isCurrent = i == _currentIndex;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? AppTheme.tertiary
                        : isAnswered
                            ? AppTheme.secondary
                            : (isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.black.withValues(alpha: 0.06)),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),

        // Anonymous badge
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Domanda ${_currentIndex + 1} di ${_questions.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.visibility_off_rounded,
                    size: 14,
                    color: isDark ? Colors.white38 : Colors.black26,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Anonimo',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white38 : Colors.black26,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Question
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  q.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 40),

                // Rating scale 1-5 with emojis
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (i) {
                    final rating = i + 1;
                    final isSelected = currentAnswer?.rating == rating;
                    return GestureDetector(
                      onTap: () => _selectRating(rating),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isSelected ? 60 : 52,
                        height: isSelected ? 60 : 52,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.tertiary.withValues(alpha: 0.2)
                              : (isDark
                                  ? Colors.white.withValues(alpha: 0.06)
                                  : Colors.black.withValues(alpha: 0.04)),
                          borderRadius: BorderRadius.circular(16),
                          border: isSelected
                              ? Border.all(
                                  color: AppTheme.tertiary,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            VowSurvey.ratingEmojis[i],
                            style: TextStyle(
                              fontSize: isSelected ? 30 : 24,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 12),

                // Rating labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Per niente',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white38 : Colors.black26,
                      ),
                    ),
                    Text(
                      'Assolutamente',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white38 : Colors.black26,
                      ),
                    ),
                  ],
                ),

                if (currentAnswer != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    VowSurvey.ratingLabel(currentAnswer.rating),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.tertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        // Navigation buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          child: Row(
            children: [
              if (_currentIndex > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: _prev,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Indietro'),
                  ),
                )
              else
                const Spacer(),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _currentIndex < _questions.length - 1
                    ? FilledButton(
                        onPressed: _isCurrentAnswered ? _next : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.tertiary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Avanti',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    : FilledButton(
                        onPressed: _isComplete ? _submit : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Invia sondaggio',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResult(bool isDark) {
    final avgRating = _answers.values.fold<int>(
          0,
          (acc, a) => acc + a.rating,
        ) /
        _answers.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
      child: Column(
        children: [
          // Success header
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.secondary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppTheme.secondary,
              size: 56,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sondaggio Inviato!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: AppTheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Grazie per il tuo contributo anonimo',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
          const SizedBox(height: 24),

          // Average score
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  'Media risposte',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  avgRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.tertiary,
                  ),
                ),
                Text(
                  '/ 5.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white38 : Colors.black26,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Answer summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Riepilogo',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                ..._questions.map((q) {
                  final answer = _answers[q.id];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            q.text,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (answer != null)
                          Text(
                            VowSurvey.ratingEmojis[answer.rating - 1],
                            style: const TextStyle(fontSize: 18),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Back button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.tertiary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Torna al Team',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
