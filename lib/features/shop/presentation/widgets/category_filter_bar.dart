import 'package:flutter/material.dart';
import 'package:vigilo/features/shop/domain/models/product_category.dart';

/// Barra filtro categorie con chip orizzontali
class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  /// Categoria selezionata (null = tutte)
  final ProductCategory? selected;
  final ValueChanged<ProductCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 32,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FilterChip(
            label: 'Tutti',
            icon: Icons.grid_view_rounded,
            isSelected: selected == null,
            onTap: () => onSelected(null),
            isDark: isDark,
          ),
          const SizedBox(width: 8),
          ...ProductCategory.values.map(
            (cat) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _FilterChip(
                label: cat.label,
                icon: cat.icon,
                color: cat.color,
                isSelected: selected == cat,
                onTap: () => onSelected(
                  selected == cat ? null : cat,
                ),
                isDark: isDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    this.color,
  });

  final String label;
  final IconData icon;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? (isDark ? Colors.white70 : Colors.black54);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? chipColor.withValues(alpha: 0.15)
              : isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? chipColor.withValues(alpha: 0.4)
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected
                  ? chipColor
                  : isDark
                      ? Colors.white54
                      : Colors.black45,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? chipColor
                    : isDark
                        ? Colors.white54
                        : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
