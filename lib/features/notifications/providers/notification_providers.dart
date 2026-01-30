import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/notifications/data/notification_repository.dart';
import 'package:vigilo/features/notifications/domain/models/app_notification.dart';

// ============================================================
// Repository provider
// ============================================================

final notificationRepositoryProvider =
    Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(supabaseClientProvider));
});

// ============================================================
// Notifications provider
// ============================================================

final notificationsProvider =
    AsyncNotifierProvider<NotificationsNotifier, List<AppNotification>>(
  NotificationsNotifier.new,
);

class NotificationsNotifier extends AsyncNotifier<List<AppNotification>> {
  @override
  Future<List<AppNotification>> build() async {
    try {
      final repo = ref.read(notificationRepositoryProvider);
      return await repo.getMyNotifications();
    } on Object {
      return AppNotification.mockNotifications();
    }
  }

  /// Segna una notifica come letta.
  Future<void> markRead(String notificationId) async {
    try {
      final repo = ref.read(notificationRepositoryProvider);
      await repo.markRead(notificationId);
      ref.invalidateSelf();
      await future;
    } on Object {
      // ignore
    }
  }

  /// Segna tutte come lette.
  Future<void> markAllRead() async {
    try {
      final repo = ref.read(notificationRepositoryProvider);
      await repo.markAllRead();
      ref.invalidateSelf();
      await future;
    } on Object {
      // ignore
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(notificationRepositoryProvider);
      return repo.getMyNotifications();
    });
  }
}
