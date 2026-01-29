import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/team/presentation/pages/vow_survey_page.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class VowSurveyCard extends StatefulWidget {
  const VowSurveyCard({super.key});

  @override
  State<VowSurveyCard> createState() => _VowSurveyCardState();
}

class _VowSurveyCardState extends State<VowSurveyCard> {
  int _safetyRating = 3;
  String? _selectedRisk;
  bool? _reportedDanger;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
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
                  color: AppTheme.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.poll_rounded,
                  color: AppTheme.tertiary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.vowSurveyTitle ?? 'SONDAGGIO — Voce del Lavoratore',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '+50 pt',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n?.surveyStatus(0, 4) ?? 'Stato: BOZZA (0/4 risposte)',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.neutral,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          // Question 1: Safety rating
          _buildQuestionContainer(
            isDark,
            l10n?.question(1) ?? 'Domanda 1',
            l10n?.questionSafety ?? 'Ti sei sentito al sicuro oggi?',
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() => _safetyRating = index + 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      index < _safetyRating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: AppTheme.primary,
                      size: 32,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),

          // Question 2: Risk type
          _buildQuestionContainer(
            isDark,
            l10n?.question(2) ?? 'Domanda 2',
            l10n?.questionRisk ?? 'Qual è stato il maggiore rischio?',
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChoiceChip(
                    l10n?.riskEquipment ?? 'Attrezzature', isDark),
                _buildChoiceChip(l10n?.riskProcedures ?? 'Procedure', isDark),
                _buildChoiceChip(l10n?.riskEnvironment ?? 'Ambiente', isDark),
                _buildChoiceChip(l10n?.riskOther ?? 'Altro', isDark),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Question 3: Reported danger
          _buildQuestionContainer(
            isDark,
            l10n?.question(3) ?? 'Domanda 3',
            l10n?.questionReported ?? 'Hai segnalato un pericolo?',
            Row(
              children: [
                _buildRadioOption(l10n?.yes ?? 'Sì', true, isDark),
                const SizedBox(width: 24),
                _buildRadioOption(l10n?.no ?? 'No', false, isDark),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Question 4: Comment
          _buildQuestionContainer(
            isDark,
            l10n?.question(4) ?? 'Domanda 4',
            l10n?.questionComment ?? 'Commento libero',
            TextField(
              controller: _commentController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: l10n?.writeHere ?? 'Scrivi qui...',
                hintStyle: TextStyle(
                  color: AppTheme.neutral.withValues(alpha: 0.6),
                ),
                filled: true,
                fillColor: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.03),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(14),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Submit button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (_) => const VowSurveyPage(),
                  ),
                );
              },
              icon: const Icon(Icons.send_rounded, size: 20),
              label: Text(l10n?.submitSurvey ?? 'Invia sondaggio'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.tertiary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContainer(
    bool isDark,
    String questionNumber,
    String question,
    Widget content,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                questionNumber,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.tertiary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isDark) {
    final isSelected = _selectedRisk == label;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _selectedRisk = isSelected ? null : label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.tertiary.withValues(alpha: 0.2)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: AppTheme.tertiary)
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppTheme.tertiary : null,
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, bool value, bool isDark) {
    final isSelected = _reportedDanger == value;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _reportedDanger = value);
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppTheme.tertiary : AppTheme.neutral,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: AppTheme.tertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
