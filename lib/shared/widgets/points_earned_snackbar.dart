import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Snackbar animato per feedback punti guadagnati
class PointsEarnedSnackbar {
  PointsEarnedSnackbar._();

  /// Mostra banner "+X Punti Elmetto" con colore ambra
  static void show(
    BuildContext context, {
    required int points,
    String? action,
  }) {
    final message = action != null
        ? '+$points Punti Elmetto - $action'
        : '+$points Punti Elmetto';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.construction_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.ambra,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
