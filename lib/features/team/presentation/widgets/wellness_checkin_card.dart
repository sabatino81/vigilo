import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class WellnessCheckinCard extends StatefulWidget {
  const WellnessCheckinCard({super.key});

  @override
  State<WellnessCheckinCard> createState() => _WellnessCheckinCardState();
}

class _WellnessCheckinCardState extends State<WellnessCheckinCard> {
  int? _selectedMood;

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
              Text(
                l10n?.wellnessTitle ?? 'COME TI SENTI OGGI?',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Mood options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMoodOption(0, '😀', l10n?.moodGreat ?? 'Ottimo',
                  AppTheme.secondary, isDark),
              _buildMoodOption(1, '😐', l10n?.moodOkay ?? 'Così così',
                  AppTheme.warning, isDark),
              _buildMoodOption(2, '😟', l10n?.moodStressed ?? 'Stressato',
                  AppTheme.danger, isDark),
            ],
          ),
          const SizedBox(height: 16),

          // Anonymous note
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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

  Widget _buildMoodOption(
    int index,
    String emoji,
    String label,
    Color color,
    bool isDark,
  ) {
    final isSelected = _selectedMood == index;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _selectedMood = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.2)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03)),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: color, width: 2)
              : null,
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? color : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
