import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';
import 'package:vigilo/shared/widgets/points_earned_snackbar.dart';

class WellnessCheckinCard extends StatefulWidget {
  const WellnessCheckinCard({super.key});

  @override
  State<WellnessCheckinCard> createState() => _WellnessCheckinCardState();
}

class _WellnessCheckinCardState extends State<WellnessCheckinCard> {
  int? _selectedMood;
  bool _submitted = false;
  final _noteController = TextEditingController();

  static const _moods = [
    ('😁', 'Ottimo'),
    ('🙂', 'Bene'),
    ('😐', 'Così così'),
    ('😟', 'Stressato'),
    ('😩', 'Male'),
  ];

  static const _moodColors = [
    AppTheme.secondary,
    Color(0xFF66BB6A),
    AppTheme.warning,
    Color(0xFFFF7043),
    AppTheme.danger,
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_selectedMood == null) return;
    HapticFeedback.mediumImpact();
    setState(() => _submitted = true);
    PointsEarnedSnackbar.show(
      context,
      points: 10,
      action: 'Check-in benessere',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  color: AppTheme.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.mood_rounded,
                  color: AppTheme.warning,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n?.wellnessTitle ?? 'COME TI SENTI OGGI?',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              if (_submitted)
                Icon(
                  Icons.check_circle_rounded,
                  color: AppTheme.secondary,
                  size: 22,
                ),
            ],
          ),
          const SizedBox(height: 20),

          // 5 mood emoji scale
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_moods.length, (i) {
              return _buildMoodOption(i, isDark);
            }),
          ),

          // Optional notes field (visible after mood selection)
          if (_selectedMood != null && !_submitted) ...[
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 2,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: l10n?.wellnessNoteHint ??
                    'Note (opzionale)...',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white38 : Colors.black26,
                ),
                filled: true,
                fillColor: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.03),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                counterStyle: TextStyle(
                  fontSize: 10,
                  color: isDark ? Colors.white38 : Colors.black26,
                ),
              ),
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _onSubmit,
                style: FilledButton.styleFrom(
                  backgroundColor: _moodColors[_selectedMood!],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n?.wellnessSubmit ?? 'Invia check-in',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],

          // Submitted confirmation
          if (_submitted) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppTheme.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.wellnessSubmitted ??
                        'Check-in inviato! +10 punti',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Anonymous note
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.visibility_off_rounded,
                  color: AppTheme.neutral.withValues(alpha: 0.6),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    l10n?.anonymousData ?? 'Anonimo - dati aggregati',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.neutral.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodOption(int index, bool isDark) {
    final isSelected = _selectedMood == index;
    final emoji = _moods[index].$1;
    final color = _moodColors[index];

    return GestureDetector(
      onTap: _submitted
          ? null
          : () {
              HapticFeedback.lightImpact();
              setState(() => _selectedMood = index);
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.2)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03)),
          borderRadius: BorderRadius.circular(14),
          border: isSelected
              ? Border.all(color: color, width: 2)
              : null,
        ),
        child: Text(
          emoji,
          style: TextStyle(
            fontSize: isSelected ? 32 : 28,
          ),
        ),
      ),
    );
  }
}
