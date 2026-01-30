import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/features/notifications/domain/models/app_notification.dart';
import 'package:vigilo/features/notifications/providers/notification_providers.dart';

/// Centro notifiche — ConsumerStatefulWidget con dati da Supabase.
class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  NotificationCategory? _filter;

  List<AppNotification> _applyFilter(List<AppNotification> notifications) {
    if (_filter == null) return notifications;
    return notifications
        .where((n) => n.category == _filter)
        .toList();
  }

  String _groupLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);
    final diff = today.difference(d).inDays;

    if (diff == 0) return 'Oggi';
    if (diff == 1) return 'Ieri';
    if (diff <= 7) return 'Questa settimana';
    return 'Precedenti';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notificationsAsync = ref.watch(notificationsProvider);

    final allNotifications = notificationsAsync.when(
      data: (n) => n,
      loading: () => <AppNotification>[],
      error: (_, __) => <AppNotification>[],
    );

    final filtered = _applyFilter(allNotifications);

    final grouped = <String, List<AppNotification>>{};
    for (final n in filtered) {
      final label = _groupLabel(n.createdAt);
      grouped.putIfAbsent(label, () => []);
      grouped[label]!.add(n);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifiche',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _CategoryChip(
                  label: 'Tutte',
                  isSelected: _filter == null,
                  onTap: () => setState(() => _filter = null),
                  isDark: isDark,
                ),
                const SizedBox(width: 8),
                ...NotificationCategory.values.map(
                  (cat) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _CategoryChip(
                      label: cat.label,
                      color: cat.color,
                      isSelected: _filter == cat,
                      onTap: () => setState(
                        () => _filter = _filter == cat ? null : cat,
                      ),
                      isDark: isDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Grouped list
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(notificationsProvider);
              },
              child: filtered.isEmpty
                  ? ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Text(
                              'Nessuna notifica',
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white54
                                    : Colors.black45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      physics:
                          const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        4,
                        16,
                        120,
                      ),
                      itemCount: grouped.length,
                      itemBuilder: (_, groupIdx) {
                        final label =
                            grouped.keys.elementAt(groupIdx);
                        final items = grouped[label]!;

                        return Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 8,
                              ),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.black45,
                                ),
                              ),
                            ),
                            ...items.map(
                              (notification) => _NotificationTile(
                                notification: notification,
                                isDark: isDark,
                                onTap: () {
                                  if (!notification.isRead) {
                                    ref
                                        .read(notificationsProvider
                                            .notifier)
                                        .markRead(notification.id);
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    this.color,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? (isDark ? Colors.white70 : Colors.black54);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? c.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? c.withValues(alpha: 0.3)
                : isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? c
                : isDark
                    ? Colors.white54
                    : Colors.black45,
          ),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.isDark,
    required this.onTap,
  });

  final AppNotification notification;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.transparent
              : notification.category.color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead
                ? (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04))
                : notification.category.color
                    .withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: notification.category.color
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                notification.category.icon,
                color: notification.category.color,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: notification.isRead
                          ? FontWeight.w500
                          : FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _timeAgo(notification.createdAt),
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white30 : Colors.black26,
                    ),
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notification.category.color,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min fa';
    if (diff.inHours < 24) return '${diff.inHours}h fa';
    return '${diff.inDays}g fa';
  }
}
