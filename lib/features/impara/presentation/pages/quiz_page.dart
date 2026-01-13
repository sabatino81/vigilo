import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/impara/domain/models/quiz.dart';
import 'package:vigilo/features/impara/presentation/pages/quiz_result_page.dart';

/// Pagina Quiz con domande
class QuizPage extends StatefulWidget {
  const QuizPage({
    required this.quiz,
    super.key,
  });

  final Quiz quiz;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  final List<int?> _answers = [];
  bool _showExplanation = false;

  @override
  void initState() {
    super.initState();
    _answers.addAll(List.filled(widget.quiz.questions.length, null));
  }

  QuizQuestion get _question => widget.quiz.questions[_currentQuestion];
  bool get _isLastQuestion =>
      _currentQuestion == widget.quiz.questions.length - 1;
  bool get _hasAnswered => _answers[_currentQuestion] != null;
  bool get _canProceed => _hasAnswered;

  void _selectAnswer(int index) {
    if (_hasAnswered) return;

    HapticFeedback.lightImpact();
    setState(() {
      _answers[_currentQuestion] = index;
      _showExplanation = true;
    });
  }

  void _nextQuestion() {
    if (_isLastQuestion) {
      _finishQuiz();
    } else {
      setState(() {
        _currentQuestion++;
        _showExplanation = false;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestion > 0) {
      setState(() {
        _currentQuestion--;
        _showExplanation = _answers[_currentQuestion] != null;
      });
    }
  }

  void _finishQuiz() {
    final correctAnswers = _answers.asMap().entries.where((entry) {
      final question = widget.quiz.questions[entry.key];
      return entry.value == question.correctIndex;
    }).length;

    final result = QuizResult(
      quizId: widget.quiz.id,
      totalQuestions: widget.quiz.questions.length,
      correctAnswers: correctAnswers,
      answers: _answers.map((a) => a ?? -1).toList(),
      completedAt: DateTime.now(),
      earnedPoints: correctAnswers >= (widget.quiz.questions.length * 0.6)
          ? widget.quiz.points
          : 0,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => QuizResultPage(
          quiz: widget.quiz,
          result: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final progress = (_currentQuestion + 1) / widget.quiz.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => _showExitDialog(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Domanda ${_currentQuestion + 1} '
                        'di ${widget.quiz.questions.length}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      Text(
                        '+${widget.quiz.points} pt',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.withValues(alpha: 0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.tertiary,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            // Domanda e risposte
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Domanda
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
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
                      child: Text(
                        _question.text,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Opzioni
                    ...List.generate(_question.options.length, (index) {
                      final isSelected = _answers[_currentQuestion] == index;
                      final isCorrect = index == _question.correctIndex;
                      final showResult = _hasAnswered;

                      Color? backgroundColor;
                      Color? borderColor;
                      Color? textColor;

                      if (showResult) {
                        if (isCorrect) {
                          backgroundColor =
                              AppTheme.secondary.withValues(alpha: 0.15);
                          borderColor = AppTheme.secondary;
                          textColor = AppTheme.secondary;
                        } else if (isSelected) {
                          backgroundColor =
                              AppTheme.danger.withValues(alpha: 0.15);
                          borderColor = AppTheme.danger;
                          textColor = AppTheme.danger;
                        }
                      } else if (isSelected) {
                        backgroundColor =
                            AppTheme.tertiary.withValues(alpha: 0.15);
                        borderColor = AppTheme.tertiary;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => _selectAnswer(index),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: backgroundColor ??
                                  (isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : Colors.grey.withValues(alpha: 0.08)),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: borderColor ??
                                    (isDark
                                        ? Colors.white.withValues(alpha: 0.1)
                                        : Colors.grey.withValues(alpha: 0.2)),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: borderColor?.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: borderColor ??
                                          (isDark
                                              ? Colors.white38
                                              : Colors.black26),
                                    ),
                                  ),
                                  child: Center(
                                    child: showResult
                                        ? Icon(
                                            isCorrect
                                                ? Icons.check_rounded
                                                : (isSelected
                                                    ? Icons.close_rounded
                                                    : null),
                                            size: 18,
                                            color: borderColor,
                                          )
                                        : Text(
                                            String.fromCharCode(65 + index),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: borderColor ??
                                                  (isDark
                                                      ? Colors.white70
                                                      : Colors.black54),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    _question.options[index],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: textColor ??
                                          (isDark
                                              ? Colors.white
                                              : Colors.black87),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    // Spiegazione
                    if (_showExplanation && _question.explanation != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.tertiary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.tertiary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lightbulb_outline_rounded,
                              color: AppTheme.tertiary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _question.explanation!,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Bottoni navigazione
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_currentQuestion > 0)
                    OutlinedButton.icon(
                      onPressed: _previousQuestion,
                      icon: const Icon(Icons.arrow_back_rounded, size: 20),
                      label: const Text('Indietro'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  if (_currentQuestion > 0) const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _canProceed ? _nextQuestion : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.tertiary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _isLastQuestion ? 'Termina Quiz' : 'Avanti',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Uscire dal quiz?'),
        content: const Text(
          'Il tuo progresso non verrà salvato.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.danger,
            ),
            child: const Text('Esci'),
          ),
        ],
      ),
    );
  }
}
