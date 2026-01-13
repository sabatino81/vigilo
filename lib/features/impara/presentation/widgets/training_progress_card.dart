import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/impara/domain/models/certificate.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

/// Card Progresso Formativo con moduli e certificati
class TrainingProgressCard extends StatelessWidget {
  const TrainingProgressCard({
    required this.progress,
    super.key,
  });

  final TrainingProgress progress;

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
                  color: AppTheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  color: AppTheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.imparaTrainingProgress,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Progress bar
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.imparaProgressLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress.progressPercentage,
                        backgroundColor: isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.secondary,
                        ),
                        minHeight: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${progress.progressPercent}%',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.imparaModulesCompleted(
              progress.completedModules.toString(),
              progress.totalModules.toString(),
            ),
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(height: 16),

          // Moduli in corso
          if (progress.inProgressModules.isNotEmpty) ...[
            Text(
              l10n.imparaModulesInProgress,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            ...progress.inProgressModules.map(
              (module) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.play_circle_outline_rounded,
                      size: 16,
                      color: AppTheme.warning,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      module,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Certificati
          if (progress.certificates.isNotEmpty) ...[
            Text(
              l10n.imparaCertificatesObtained,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            ...progress.certificates.map(
              (cert) => _CertificateTile(
                certificate: cert,
                isDark: isDark,
                l10n: l10n,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CertificateTile extends StatelessWidget {
  const _CertificateTile({
    required this.certificate,
    required this.isDark,
    required this.l10n,
  });

  final Certificate certificate;
  final bool isDark;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.secondary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              color: AppTheme.secondary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  certificate.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                if (certificate.expiresAt != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    certificate.isExpiringSoon
                        ? l10n.imparaCertificateExpiring
                        : l10n.imparaCertificateValid,
                    style: TextStyle(
                      fontSize: 11,
                      color: certificate.isExpiringSoon
                          ? AppTheme.warning
                          : AppTheme.secondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(
            Icons.verified_rounded,
            color: AppTheme.secondary,
            size: 20,
          ),
        ],
      ),
    );
  }
}
