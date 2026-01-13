import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/points_level.dart';
import 'package:vigilo/features/punti/domain/models/points_transaction.dart';

/// Card wallet con saldo punti, livello e movimenti recenti
class WalletCard extends StatelessWidget {
  const WalletCard({
    required this.totalPoints,
    required this.transactions,
    this.onViewAllTransactions,
    super.key,
  });

  final int totalPoints;
  final List<PointsTransaction> transactions;
  final VoidCallback? onViewAllTransactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final level = PointsLevel.fromPoints(totalPoints);
    final progress = PointsLevel.progressToNextLevel(totalPoints);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF2A2A2A),
                  const Color(0xFF1A1A1A),
                ]
              : [
                  Colors.white,
                  const Color(0xFFF5F5F5),
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: isDark ? 0.2 : 0.15),
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
                  color: AppTheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppTheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'WALLET',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Saldo totale
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$totalPoints',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.black87,
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'punti',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Livello e progresso
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: level.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      level.icon,
                      color: level.color,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Livello ${level.label}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: level.color,
                      ),
                    ),
                    const Spacer(),
                    if (level.nextLevel != null)
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: level.color,
                        ),
                      ),
                  ],
                ),
                if (level.nextLevel != null) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.black.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(level.color),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Prossimo: ${level.nextLevel!.label} '
                    '(${level.maxPoints} pt)',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Movimenti recenti
          Row(
            children: [
              Text(
                'Movimenti recenti',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const Spacer(),
              if (onViewAllTransactions != null)
                GestureDetector(
                  onTap: onViewAllTransactions,
                  child: Text(
                    'Vedi tutti',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ...transactions.take(4).map(
                (tx) => _TransactionTile(transaction: tx, isDark: isDark),
              ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.transaction,
    required this.isDark,
  });

  final PointsTransaction transaction;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: transaction.type.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transaction.type.icon,
              color: transaction.type.color,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              transaction.description,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white : Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            transaction.formattedAmount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: transaction.type.color,
            ),
          ),
        ],
      ),
    );
  }
}
