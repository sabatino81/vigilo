import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Card per la verifica dell'accesso al cantiere secondo D.Lgs. 81/2008
/// Mostra stato accesso, DPI rilevati, e documenti obbligatori
class SiteAccessCard extends ConsumerWidget {
  const SiteAccessCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // TODO: Collegare a provider per dati reali
    final accessGranted = true;
    final lastCheckTime = '07:02';

    // DPI status (in futuro da IoT/Computer Vision)
    final dpiStatus = {
      'Casco': true,
      'Giubbino': true,
      'Scarponi': true,
    };

    // Documenti obbligatori
    final documents = {
      'Idoneità': true,
      'DPI Base': true,
      'Formazione': true,
    };

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: accessGranted
              ? AppTheme.secondary.withOpacity(0.3)
              : AppTheme.danger.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con icona e titolo
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accessGranted
                        ? AppTheme.secondary.withOpacity(0.15)
                        : AppTheme.danger.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.verified_user_outlined,
                    color: accessGranted ? AppTheme.secondary : AppTheme.danger,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACCESSO CANTIERE',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'D.Lgs. 81/2008',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Stato attuale
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: accessGranted
                    ? AppTheme.secondary.withOpacity(0.1)
                    : AppTheme.danger.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: accessGranted
                      ? AppTheme.secondary.withOpacity(0.3)
                      : AppTheme.danger.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    accessGranted ? Icons.check_circle : Icons.cancel,
                    color: accessGranted ? AppTheme.secondary : AppTheme.danger,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accessGranted
                              ? 'Accesso consentito'
                              : 'Accesso NON consentito',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: accessGranted
                                ? AppTheme.secondary
                                : AppTheme.danger,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ultimo check: Oggi alle $lastCheckTime',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // DPI rilevati
            Text(
              'DPI rilevati',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: dpiStatus.entries.map((entry) {
                return _StatusChip(
                  label: entry.key,
                  isValid: entry.value,
                  theme: theme,
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Documenti obbligatori
            Text(
              'Documenti obbligatori',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: documents.entries.map((entry) {
                return _StatusChip(
                  label: entry.key,
                  isValid: entry.value,
                  theme: theme,
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Action button - Accesso cantiere
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Avviare procedura accesso cantiere
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Procedura accesso cantiere avviata...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondary,
                  foregroundColor: AppTheme.onSecondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'ACCEDI AL CANTIERE',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget chip per mostrare stato DPI/Documenti
class _StatusChip extends StatelessWidget {
  final String label;
  final bool isValid;
  final ThemeData theme;

  const _StatusChip({
    required this.label,
    required this.isValid,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isValid
            ? AppTheme.secondary.withOpacity(0.12)
            : AppTheme.danger.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isValid
              ? AppTheme.secondary.withOpacity(0.4)
              : AppTheme.danger.withOpacity(0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isValid ? AppTheme.secondary : AppTheme.danger,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isValid ? AppTheme.secondary : AppTheme.danger,
            ),
          ),
        ],
      ),
    );
  }
}
