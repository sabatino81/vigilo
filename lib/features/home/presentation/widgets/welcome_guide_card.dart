import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class WelcomeGuideCard extends StatelessWidget {
  const WelcomeGuideCard({super.key});

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
          color: AppTheme.tertiary.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.tertiary.withValues(alpha: isDark ? 0.15 : 0.1),
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
                  Icons.shield_rounded,
                  color: AppTheme.tertiary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n?.welcomeGuideTitle ??
                      'LA TUA SICUREZZA A PORTATA DI MANO',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Image and PPE section side by side
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Safety Guide Image with rounded corners
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/SafetyGuide.png',
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // PPE List
              Expanded(
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : AppTheme.tertiary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.verified_user_rounded,
                            color: AppTheme.tertiary,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              l10n?.ppeProtected ?? 'DPI ATTIVI',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.tertiary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildPpeItem(
                        Icons.construction,
                        l10n?.dpiHelmet ?? 'Casco',
                        isDark,
                      ),
                      const SizedBox(height: 6),
                      _buildPpeItem(
                        Icons.do_not_step,
                        l10n?.dpiSafetyShoes ?? 'Scarpe antinfortunistiche',
                        isDark,
                      ),
                      const SizedBox(height: 6),
                      _buildPpeItem(
                        Icons.front_hand_rounded,
                        l10n?.dpiGloves ?? 'Guanti',
                        isDark,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Feature checklist
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildFeatureRow(
                  l10n?.welcomeFeature1 ?? 'Controlla il tuo Safety Score',
                  isDark,
                ),
                const SizedBox(height: 8),
                _buildFeatureRow(
                  l10n?.welcomeFeature2 ?? 'Verifica se i DPI sono attivi',
                  isDark,
                ),
                const SizedBox(height: 8),
                _buildFeatureRow(
                  l10n?.welcomeFeature3 ?? 'Segnala un pericolo con SOS',
                  isDark,
                ),
                const SizedBox(height: 8),
                _buildFeatureRow(
                  l10n?.welcomeFeature4 ?? 'Completa le attività del giorno',
                  isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Quick guide button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
              },
              icon: const Icon(Icons.arrow_forward_rounded, size: 20),
              label: Text(l10n?.openQuickGuide ?? 'Apri la guida rapida'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.tertiary,
                side: BorderSide(
                  color: AppTheme.tertiary.withValues(alpha: 0.5),
                ),
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

  Widget _buildPpeItem(IconData icon, String label, bool isDark) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.secondary,
          size: 14,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureRow(String text, bool isDark) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_rounded,
          color: AppTheme.secondary,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
