import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/impara/domain/models/training_content.dart';
import 'package:vigilo/features/impara/presentation/pages/content_detail_sheet.dart';

/// Pagina Biblioteca completa con ricerca e filtri
class LibraryPage extends StatefulWidget {
  const LibraryPage({
    required this.contents,
    super.key,
  });

  final List<TrainingContent> contents;

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final _searchController = TextEditingController();
  ContentType? _selectedType;
  ContentCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TrainingContent> get _filteredContents {
    var contents = widget.contents.toList();

    // Filtra per ricerca
    if (_searchQuery.isNotEmpty) {
      contents = contents
          .where((c) =>
              c.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              c.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Filtra per tipo
    if (_selectedType != null) {
      contents = contents.where((c) => c.type == _selectedType).toList();
    }

    // Filtra per categoria
    if (_selectedCategory != null) {
      contents =
          contents.where((c) => c.category == _selectedCategory).toList();
    }

    return contents;
  }

  void _openContent(TrainingContent content) {
    unawaited(ContentDetailSheet.show(context, content: content));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final contents = _filteredContents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barra ricerca
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cerca contenuti...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          // Filtri tipo
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FilterChip(
                  label: 'Tutti',
                  isSelected: _selectedType == null,
                  onTap: () => setState(() => _selectedType = null),
                ),
                ...ContentType.values.map(
                  (type) => _FilterChip(
                    label: type.label,
                    icon: type.icon,
                    isSelected: _selectedType == type,
                    onTap: () => setState(() => _selectedType = type),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Filtri categoria
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FilterChip(
                  label: 'Tutte',
                  isSelected: _selectedCategory == null,
                  onTap: () => setState(() => _selectedCategory = null),
                  isSecondary: true,
                ),
                ...ContentCategory.values.map(
                  (cat) => _FilterChip(
                    label: cat.label,
                    isSelected: _selectedCategory == cat,
                    onTap: () => setState(() => _selectedCategory = cat),
                    isSecondary: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Conteggio risultati
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${contents.length} contenuti',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Lista contenuti
          Expanded(
            child: contents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: isDark ? Colors.white24 : Colors.black26,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nessun contenuto trovato',
                          style: TextStyle(
                            color: isDark ? Colors.white54 : Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                    itemCount: contents.length,
                    itemBuilder: (context, index) {
                      final content = contents[index];
                      return _ContentListTile(
                        content: content,
                        isDark: isDark,
                        onTap: () => _openContent(content),
                      );
                    },
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
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.isSecondary = false,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    final color = isSecondary ? AppTheme.tertiary : AppTheme.secondary;

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
            color: isSelected ? color : Colors.grey.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: isSelected ? Colors.white : null,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentListTile extends StatelessWidget {
  const _ContentListTile({
    required this.content,
    required this.isDark,
    this.onTap,
  });

  final TrainingContent content;
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
            // Icona tipo
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: content.type.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                content.type.icon,
                color: content.type.color,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        content.category.icon,
                        size: 14,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          content.category.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white54 : Colors.black45,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.schedule_rounded,
                        size: 14,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        content.durationLabel,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white54 : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  if (content.status != ContentStatus.notStarted) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: content.status.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          content.status.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: content.status.color,
                          ),
                        ),
                        if (content.status == ContentStatus.inProgress) ...[
                          const SizedBox(width: 8),
                          Text(
                            '${(content.progress * 100).round()}%',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
            // Punti e freccia
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (content.points > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '+${content.points} pt',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? Colors.white38 : Colors.black26,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
