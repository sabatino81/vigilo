import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/reward.dart';
import 'package:vigilo/features/punti/presentation/pages/reward_detail_sheet.dart';

/// Bottom sheet catalogo premi completo
class RewardsCatalogSheet extends StatefulWidget {
  const RewardsCatalogSheet({
    required this.rewards,
    required this.userPoints,
    this.initialReward,
    super.key,
  });

  final List<Reward> rewards;
  final int userPoints;
  final Reward? initialReward;

  static Future<void> show(
    BuildContext context, {
    required List<Reward> rewards,
    required int userPoints,
    Reward? initialReward,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RewardsCatalogSheet(
        rewards: rewards,
        userPoints: userPoints,
        initialReward: initialReward,
      ),
    );
  }

  @override
  State<RewardsCatalogSheet> createState() => _RewardsCatalogSheetState();
}

class _RewardsCatalogSheetState extends State<RewardsCatalogSheet> {
  RewardCategory? _selectedCategory;
  String _sortBy = 'cost_asc';

  @override
  void initState() {
    super.initState();
    if (widget.initialReward != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showRewardDetail(widget.initialReward!);
      });
    }
  }

  List<Reward> get _filteredRewards {
    var rewards = widget.rewards.toList();

    // Filtra per categoria
    if (_selectedCategory != null) {
      rewards =
          rewards.where((r) => r.category == _selectedCategory).toList();
    }

    // Ordina
    switch (_sortBy) {
      case 'cost_asc':
        rewards.sort((a, b) => a.cost.compareTo(b.cost));
      case 'cost_desc':
        rewards.sort((a, b) => b.cost.compareTo(a.cost));
      case 'name':
        rewards.sort((a, b) => a.name.compareTo(b.name));
    }

    return rewards;
  }

  void _showRewardDetail(Reward reward) {
    unawaited(RewardDetailSheet.show(
      context,
      reward: reward,
      userPoints: widget.userPoints,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final rewards = _filteredRewards;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
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
                        'Catalogo Premi',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Punti disponibili
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.monetization_on_rounded,
                            color: AppTheme.primary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.userPoints} pt',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
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

              // Filtri
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Categorie
                    SizedBox(
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _FilterChip(
                            label: 'Tutti',
                            isSelected: _selectedCategory == null,
                            onTap: () =>
                                setState(() => _selectedCategory = null),
                          ),
                          ...RewardCategory.values.map(
                            (cat) => _FilterChip(
                              label: cat.label,
                              isSelected: _selectedCategory == cat,
                              onTap: () =>
                                  setState(() => _selectedCategory = cat),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Ordinamento
                    Row(
                      children: [
                        Text(
                          'Ordina per:',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white54 : Colors.black45,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _SortChip(
                          label: 'Punti ↑',
                          isSelected: _sortBy == 'cost_asc',
                          onTap: () => setState(() => _sortBy = 'cost_asc'),
                        ),
                        _SortChip(
                          label: 'Punti ↓',
                          isSelected: _sortBy == 'cost_desc',
                          onTap: () => setState(() => _sortBy = 'cost_desc'),
                        ),
                        _SortChip(
                          label: 'Nome',
                          isSelected: _sortBy == 'name',
                          onTap: () => setState(() => _sortBy = 'name'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Lista premi
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    final reward = rewards[index];
                    return _RewardListTile(
                      reward: reward,
                      canRedeem: reward.canRedeem(widget.userPoints),
                      isDark: isDark,
                      onTap: () => _showRewardDetail(reward),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.secondary
                : Colors.grey.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.tertiary.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? AppTheme.tertiary
                  : Colors.grey.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppTheme.tertiary : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _RewardListTile extends StatelessWidget {
  const _RewardListTile({
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
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: canRedeem
              ? Border.all(
                  color: AppTheme.secondary.withValues(alpha: 0.3),
                )
              : null,
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
        child: Row(
          children: [
            // Emoji icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  reward.icon,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        reward.category.icon,
                        size: 14,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        reward.category.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white54 : Colors.black45,
                        ),
                      ),
                      const SizedBox(width: 12),
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
                          fontSize: 12,
                          color: reward.availability.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Costo e azione
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: canRedeem
                        ? AppTheme.secondary.withValues(alpha: 0.15)
                        : isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${reward.cost} pt',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: canRedeem
                          ? AppTheme.secondary
                          : isDark
                              ? Colors.white54
                              : Colors.black45,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? Colors.white38 : Colors.black26,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
