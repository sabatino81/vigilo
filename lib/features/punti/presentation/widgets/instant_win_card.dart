import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Card Instant Win - Gira la ruota
class InstantWinCard extends StatelessWidget {
  const InstantWinCard({
    required this.hasSpinAvailable,
    this.onSpinTap,
    super.key,
  });

  final bool hasSpinAvailable;
  final VoidCallback? onSpinTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF9C27B0).withValues(alpha: isDark ? 0.3 : 0.15),
            const Color(0xFFE91E63).withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE91E63).withValues(alpha: 0.3),
          width: 1.5,
        ),
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
                  color: const Color(0xFFE91E63).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.casino_rounded,
                  color: Color(0xFFE91E63),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INSTANT WIN',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'Gira la ruota!',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE91E63),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasSpinAvailable)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.celebration_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '1 GIRO',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _InfoRow(
                  icon: Icons.today_rounded,
                  text: '1 tentativo gratuito al giorno',
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.emoji_events_rounded,
                  text: 'Premi: punti bonus e gadget',
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.money_off_rounded,
                  text: 'Nessun costo per giocare',
                  isDark: isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: hasSpinAvailable
                  ? () {
                      HapticFeedback.mediumImpact();
                      onSpinTap?.call();
                    }
                  : null,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                hasSpinAvailable ? 'GIRA LA RUOTA' : 'TORNA DOMANI',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
                foregroundColor: Colors.white,
                disabledBackgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.3),
                padding: const EdgeInsets.symmetric(vertical: 16),
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
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.text,
    required this.isDark,
  });

  final IconData icon;
  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark ? Colors.white54 : Colors.black45,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
