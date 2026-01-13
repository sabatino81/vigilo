import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/reward.dart';

/// Bottom sheet dettaglio premio
class RewardDetailSheet extends StatelessWidget {
  const RewardDetailSheet({
    required this.reward,
    required this.userPoints,
    super.key,
  });

  final Reward reward;
  final int userPoints;

  static Future<bool?> show(
    BuildContext context, {
    required Reward reward,
    required int userPoints,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RewardDetailSheet(
        reward: reward,
        userPoints: userPoints,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final canRedeem = reward.canRedeem(userPoints);
    final pointsNeeded = reward.cost - userPoints;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Dettaglio Premio',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close_rounded,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 16),

              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  children: [
                    // Icon e nome
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.grey.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                reward.icon,
                                style: const TextStyle(fontSize: 48),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            reward.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Costo
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: canRedeem
                            ? AppTheme.secondary.withValues(alpha: 0.15)
                            : isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.grey.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: canRedeem
                            ? Border.all(
                                color: AppTheme.secondary.withValues(alpha: 0.3),
                              )
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            color: canRedeem
                                ? AppTheme.secondary
                                : isDark
                                    ? Colors.white54
                                    : Colors.black45,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${reward.cost} punti',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: canRedeem
                                  ? AppTheme.secondary
                                  : isDark
                                      ? Colors.white
                                      : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!canRedeem && pointsNeeded > 0) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Ti mancano $pointsNeeded punti',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.danger,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 20),

                    // Info
                    _InfoSection(
                      title: 'Categoria',
                      icon: reward.category.icon,
                      value: reward.category.label,
                      isDark: isDark,
                    ),
                    _InfoSection(
                      title: 'Disponibilità',
                      icon: Icons.inventory_2_rounded,
                      value: reward.availability.label,
                      valueColor: reward.availability.color,
                      isDark: isDark,
                    ),
                    if (reward.deliveryInfo != null)
                      _InfoSection(
                        title: 'Consegna',
                        icon: Icons.local_shipping_rounded,
                        value: reward.deliveryInfo!,
                        isDark: isDark,
                      ),
                    const SizedBox(height: 16),

                    // Descrizione
                    Text(
                      'Descrizione',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.grey.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        reward.description,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bottoni
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text('Annulla'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: FilledButton(
                            onPressed: canRedeem
                                ? () => _confirmRedeem(context, isDark)
                                : null,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.secondary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Riscatta premio',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmRedeem(BuildContext context, bool isDark) {
    unawaited(HapticFeedback.mediumImpact());
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Conferma riscatto'),
        content: Text(
          'Vuoi riscattare "${reward.name}" per ${reward.cost} punti?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSuccessDialog(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.secondary,
            ),
            child: const Text('Conferma'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppTheme.secondary,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'PREMIO RISCATTATO!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              reward.deliveryInfo ?? 'Ritira il premio in azienda.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'CHIUDI',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.title,
    required this.icon,
    required this.value,
    required this.isDark,
    this.valueColor,
  });

  final String title;
  final IconData icon;
  final String value;
  final bool isDark;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark ? Colors.white38 : Colors.black38,
          ),
          const SizedBox(width: 10),
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? (isDark ? Colors.white : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
