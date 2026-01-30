import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/notifications/domain/models/app_notification.dart';

/// Repository per notifiche via Supabase RPC.
class NotificationRepository extends BaseRepository {
  const NotificationRepository(super.client);

  /// Notifiche dell'utente (più recenti prima).
  Future<List<AppNotification>> getMyNotifications({
    int limit = 20,
    int offset = 0,
  }) async {
    final json = await rpc<List<dynamic>>(
      'get_my_notifications',
      params: {'p_limit': limit, 'p_offset': offset},
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(AppNotification.fromJson)
        .toList();
  }

  /// Segna una notifica come letta.
  Future<void> markRead(String notificationId) async {
    await rpc<Map<String, dynamic>>(
      'mark_notification_read',
      params: {'p_notification_id': notificationId},
    );
  }

  /// Segna tutte le notifiche come lette.
  Future<void> markAllRead() async {
    await rpc<Map<String, dynamic>>('mark_all_notifications_read');
  }
}
