import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/elmetto_wallet.dart';
import 'package:vigilo/features/punti/domain/models/points_level.dart';
import 'package:vigilo/features/punti/domain/models/points_transaction.dart';

/// Card wallet unico Punti Elmetto (con badge welfare se attivo)
class ElmettoWalletCard extends StatelessWidget {
  const ElmettoWalletCard({
    required this.wallet,
    this.onViewAllTransactions,
    super.key,
  });

  final ElmettoWallet wallet;
  final VoidCallback? onViewAllTransactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final level = PointsLevel.fromPoints(wallet.puntiElmetto);
    final progress = PointsLevel.progressToNextLevel(wallet.puntiElmetto);

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
          color: AppTheme.ambra.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.ambra.withValues(alpha: isDark ? 0.2 : 0.15),
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
                  color: AppTheme.ambra.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.construction_rounded,
                  color: AppTheme.ambra,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'PUNTI ELMETTO',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
              if (wallet.welfareActive)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: 14,
                        color: AppTheme.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'WELFARE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.secondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Saldo unico grande
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${wallet.puntiElmetto}',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.black87,
                  height: 1,
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'pt',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '= ${wallet.elmettoValueEur.toStringAsFixed(0)} EUR',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.ambra,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Info conversione + cap sconto
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 14,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    wallet.welfareActive
                        ? '${ElmettoWallet.elmettoPerEur} pt = 1 EUR  |  '
                            'Sconto fino al 100% (welfare attivo)'
                        : '${ElmettoWallet.elmettoPerEur} pt = 1 EUR  |  '
                            'Max ${ElmettoWallet.maxDiscountNoWelfare}% sconto',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (wallet.welfareActive && wallet.companyName != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.business_rounded,
                    size: 14,
                    color: AppTheme.secondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Welfare attivato da ${wallet.companyName}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),

          // Livello Elmetto
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
                    Icon(level.icon, color: level.color, size: 20),
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
                      valueColor:
                          AlwaysStoppedAnimation<Color>(level.color),
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

          // Header transazioni
          Row(
            children: [
              Text(
                'Ultime transazioni',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const Spacer(),
              if (onViewAllTransactions != null)
                GestureDetector(
                  onTap: onViewAllTransactions,
                  child: const Text(
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

          // Lista transazioni
          ...wallet.transactions.take(5).map(
                (tx) => _TransactionTile(
                  transaction: tx,
                  isDark: isDark,
                ),
              ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Come guadagnare punti
          _HowToEarnSection(isDark: isDark),
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

class _HowToEarnSection extends StatelessWidget {
  const _HowToEarnSection({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white54 : Colors.black45;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.emoji_events_rounded,
              color: AppTheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Come guadagni Punti Elmetto',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: titleColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        Text(
          'AZIONI INDIVIDUALI',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppTheme.tertiary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        _earnRow(Icons.wb_sunny_rounded, 'Check-in benessere',
            '+5/giorno', titleColor, subtitleColor),
        _earnRow(Icons.rate_review_rounded, 'Feedback fine turno',
            '+10/giorno', titleColor, subtitleColor),
        _earnRow(Icons.warning_amber_rounded, 'Segnalazione rischio',
            '+30-50', titleColor, subtitleColor),
        _earnRow(Icons.star_rounded, 'Nomina Safety Star',
            '+15 (tu) +25 (collega)', titleColor, subtitleColor),
        _earnRow(Icons.local_fire_department_rounded, 'Streak giornaliero',
            '+5-25/giorno', titleColor, subtitleColor),

        const SizedBox(height: 10),
        Text(
          'AZIONI DI SQUADRA',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppTheme.secondary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        _earnRow(Icons.groups_rounded, 'Sfida team completata',
            '+50-100/membro', titleColor, subtitleColor),
        _earnRow(Icons.forum_rounded, 'Post e commenti social',
            '+3-5 (max 30/gg)', titleColor, subtitleColor),

        const SizedBox(height: 10),
        Text(
          'FORMAZIONE',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppTheme.warning,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        _earnRow(Icons.play_circle_rounded, 'Micro-training',
            '+15/giorno', titleColor, subtitleColor),
        _earnRow(Icons.quiz_rounded, 'Quiz settimanale',
            '+20 (+10 se >80%)', titleColor, subtitleColor),
        _earnRow(Icons.school_rounded, 'Corso completato',
            '+30-80', titleColor, subtitleColor),
      ],
    );
  }

  Widget _earnRow(
    IconData icon,
    String label,
    String points,
    Color titleColor,
    Color subtitleColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: subtitleColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: titleColor,
              ),
            ),
          ),
          Text(
            points,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
