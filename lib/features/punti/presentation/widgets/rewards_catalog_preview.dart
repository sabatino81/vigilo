import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/reward.dart';

/// Preview del catalogo premi (mostra 5 premi + link vedi tutto)
class RewardsCatalogPreview extends StatelessWidget {
  const RewardsCatalogPreview({
    required this.rewards,
    required this.userPoints,
    this.onRewardTap,
    this.onViewAllTap,
    super.key,
  });

  final List<Reward> rewards;
  final int userPoints;
  final void Function(Reward)? onRewardTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
                  color: AppTheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.card_giftcard_rounded,
                  color: AppTheme.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'CATALOGO PREMI',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Lista premi
          ...rewards.take(5).map(
                (reward) => _RewardPreviewTile(
                  reward: reward,
                  canRedeem: reward.canRedeem(userPoints),
                  isDark: isDark,
                  onTap: () => onRewardTap?.call(reward),
                ),
              ),

          // Vedi tutto
          if (onViewAllTap != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onViewAllTap?.call();
                },
                icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                label: const Text('Vedi tutto il catalogo'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.secondary,
                  side: BorderSide(
                    color: AppTheme.secondary.withValues(alpha: 0.5),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RewardPreviewTile extends StatelessWidget {
  const _RewardPreviewTile({
    required this.reward,
    required this.canRedeem,
    required this.isDark,
    this.onTap,
  });

  final Reward reward;
  final bool canRedeem;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // Emoji icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  reward.icon,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Nome e disponibilità
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: reward.availability.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        reward.availability.label,
                        style: TextStyle(
                          fontSize: 11,
                          color: reward.availability.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Costo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: canRedeem
                    ? AppTheme.secondary.withValues(alpha: 0.15)
                    : isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${reward.cost} pt',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: canRedeem
                      ? AppTheme.secondary
                      : isDark
                          ? Colors.white54
                          : Colors.black45,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark ? Colors.white38 : Colors.black26,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
