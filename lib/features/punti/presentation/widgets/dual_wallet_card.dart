import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/dual_wallet.dart';
import 'package:vigilo/features/punti/domain/models/points_level.dart';
import 'package:vigilo/features/punti/domain/models/points_transaction.dart';
import 'package:vigilo/features/punti/domain/models/wallet_type.dart';
import 'package:vigilo/features/punti/domain/models/welfare_plan.dart';

/// Card wallet duale: Punti Elmetto + Punti Welfare
class DualWalletCard extends StatefulWidget {
  const DualWalletCard({
    required this.wallet,
    this.onViewAllTransactions,
    super.key,
  });

  final DualWallet wallet;
  final VoidCallback? onViewAllTransactions;

  @override
  State<DualWalletCard> createState() => _DualWalletCardState();
}

class _DualWalletCardState extends State<DualWalletCard> {
  WalletType _selectedTab = WalletType.elmetto;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final level = PointsLevel.fromPoints(widget.wallet.puntiElmetto);
    final progress =
        PointsLevel.progressToNextLevel(widget.wallet.puntiElmetto);

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
          const SizedBox(height: 16),

          // Due saldi affiancati
          Row(
            children: [
              Expanded(
                child: _BalanceSection(
                  walletType: WalletType.elmetto,
                  value: '${widget.wallet.puntiElmetto}',
                  unit: 'pt',
                  subtitle:
                      '= ${widget.wallet.elmettoValueEur.toStringAsFixed(0)}'
                      ' EUR',
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BalanceSection(
                  walletType: WalletType.welfare,
                  value: widget.wallet.welfarePlan.remainingEur
                      .toStringAsFixed(0),
                  unit: 'EUR',
                  subtitle: widget.wallet.welfarePlan.tier.label,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Info conversione
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
                    '${DualWallet.elmettoPerEur} Elmetto = 1 EUR'
                    '  |  Max ${DualWallet.maxElmettoDiscountPercent}%'
                    ' sconto',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          ),
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

          // Budget welfare progress
          _WelfareBudgetBar(
            plan: widget.wallet.welfarePlan,
            isDark: isDark,
          ),
          const SizedBox(height: 16),

          // Tab switch Elmetto/Welfare
          Row(
            children: [
              _TabButton(
                label: 'Elmetto',
                icon: WalletType.elmetto.icon,
                color: WalletType.elmetto.color,
                isSelected: _selectedTab == WalletType.elmetto,
                onTap: () =>
                    setState(() => _selectedTab = WalletType.elmetto),
              ),
              const SizedBox(width: 8),
              _TabButton(
                label: 'Welfare',
                icon: WalletType.welfare.icon,
                color: WalletType.welfare.color,
                isSelected: _selectedTab == WalletType.welfare,
                onTap: () =>
                    setState(() => _selectedTab = WalletType.welfare),
              ),
              const Spacer(),
              if (widget.onViewAllTransactions != null)
                GestureDetector(
                  onTap: widget.onViewAllTransactions,
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
          ..._currentTransactions.take(4).map(
                (tx) => _TransactionTile(
                  transaction: tx,
                  isDark: isDark,
                ),
              ),
        ],
      ),
    );
  }

  List<PointsTransaction> get _currentTransactions {
    return _selectedTab == WalletType.elmetto
        ? widget.wallet.elmettoTransactions
        : widget.wallet.welfareTransactions;
  }
}

// ============================================
// PRIVATE WIDGETS
// ============================================

class _BalanceSection extends StatelessWidget {
  const _BalanceSection({
    required this.walletType,
    required this.value,
    required this.unit,
    required this.subtitle,
    required this.isDark,
  });

  final WalletType walletType;
  final String value;
  final String unit;
  final String subtitle;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final color = isDark ? walletType.colorDark : walletType.color;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(walletType.icon, color: color, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  walletType.shortLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.black87,
                  height: 1,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  unit,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}

class _WelfareBudgetBar extends StatelessWidget {
  const _WelfareBudgetBar({
    required this.plan,
    required this.isDark,
  });

  final WelfarePlan plan;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final usagePercent = plan.usagePercent.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.favorite_rounded,
              size: 14,
              color: isDark ? AppTheme.tealDark : AppTheme.teal,
            ),
            const SizedBox(width: 6),
            Text(
              'Budget Welfare mensile',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const Spacer(),
            Text(
              '${plan.usedEur.toStringAsFixed(0)}'
              ' / ${plan.monthlyBudgetEur.toStringAsFixed(0)} EUR',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: usagePercent,
            backgroundColor: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
              isDark ? AppTheme.tealDark : AppTheme.teal,
            ),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? color.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected
                  ? color
                  : Theme.of(context).brightness == Brightness.dark
                      ? Colors.white38
                      : Colors.black38,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? color
                    : Theme.of(context).brightness == Brightness.dark
                        ? Colors.white38
                        : Colors.black38,
              ),
            ),
          ],
        ),
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
