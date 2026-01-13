import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/sos/domain/models/safety_report.dart';
import 'package:vigilo/features/sos/presentation/widgets/report_status_badge.dart';

/// Bottom sheet per visualizzare i dettagli di una segnalazione
class ReportDetailSheet extends StatelessWidget {
  const ReportDetailSheet({
    required this.report,
    super.key,
  });

  final SafetyReport report;

  /// Mostra il bottom sheet con animazione smooth
  static Future<void> show(BuildContext context, SafetyReport report) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReportDetailSheet(report: report),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')} - '
        '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.4,
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
                        'La tua segnalazione',
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
                    // Header con tipo e status
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: report.type.backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  report.type.icon,
                                  color: report.type.color,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      report.type.label,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: report.type.color,
                                      ),
                                    ),
                                    if (report.reportCode != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        report.reportCode!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'monospace',
                                          color: report.type.color
                                              .withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ReportStatusBadge(status: report.status),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Info card
                    _InfoCard(
                      isDark: isDark,
                      children: [
                        _InfoRow(
                          icon: Icons.calendar_today_rounded,
                          label: 'Quando',
                          value: _formatDateTime(report.createdAt),
                          isDark: isDark,
                        ),
                        if (report.locationName != null) ...[
                          const SizedBox(height: 16),
                          _InfoRow(
                            icon: Icons.location_on_rounded,
                            label: 'Dove',
                            value: report.locationName!,
                            isDark: isDark,
                          ),
                        ],
                        if (report.contactRequested) ...[
                          const SizedBox(height: 16),
                          _InfoRow(
                            icon: Icons.phone_callback_rounded,
                            label: 'Richiamami',
                            value: 'Sì',
                            isDark: isDark,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Descrizione
                    _SectionCard(
                      title: 'Cosa hai scritto',
                      icon: Icons.description_rounded,
                      isDark: isDark,
                      child: Text(
                        report.description,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),

                    // Foto (se presenti)
                    if (report.photoUrls.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _SectionCard(
                        title: 'Foto',
                        icon: Icons.photo_library_rounded,
                        isDark: isDark,
                        child: SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: report.photoUrls.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  report.photoUrls[index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey[300],
                                    child:
                                        const Icon(Icons.broken_image_rounded),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],

                    // Note RSPP (se presenti)
                    if (report.rsppNotes != null &&
                        report.rsppNotes!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _SectionCard(
                        title: 'Risposta del responsabile',
                        icon: Icons.note_alt_rounded,
                        isDark: isDark,
                        highlight: true,
                        child: Text(
                          report.rsppNotes!,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],

                    // Data risoluzione (se presente)
                    if (report.resolvedAt != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.secondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.secondary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: AppTheme.secondary,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Problema risolto',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.secondary,
                                    ),
                                  ),
                                  Text(
                                    _formatDateTime(report.resolvedAt!),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.secondary
                                          .withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.children,
    required this.isDark,
  });

  final List<Widget> children;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.isDark,
    required this.child,
    this.highlight = false,
  });

  final String title;
  final IconData icon;
  final bool isDark;
  final Widget child;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlight
            ? AppTheme.tertiary.withValues(alpha: 0.05)
            : isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: highlight
            ? Border.all(
                color: AppTheme.tertiary.withValues(alpha: 0.2),
              )
            : null,
        boxShadow: isDark || highlight
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
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: highlight
                    ? AppTheme.tertiary
                    : isDark
                        ? Colors.white54
                        : Colors.black45,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: highlight
                      ? AppTheme.tertiary
                      : isDark
                          ? Colors.white54
                          : Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
