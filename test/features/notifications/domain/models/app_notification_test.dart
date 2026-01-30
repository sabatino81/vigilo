import 'package:test/test.dart';
import 'package:vigilo/features/notifications/domain/models/app_notification.dart';

void main() {
  group('AppNotification.fromJson', () {
    test('parses complete JSON', () {
      final json = {
        'id': 'n1',
        'title': 'Test Notification',
        'body': 'This is a test',
        'category': 'safety',
        'created_at': '2025-01-15T10:00:00Z',
        'is_read': true,
      };

      final notif = AppNotification.fromJson(json);
      expect(notif.id, 'n1');
      expect(notif.title, 'Test Notification');
      expect(notif.body, 'This is a test');
      expect(notif.category, NotificationCategory.safety);
      expect(notif.isRead, isTrue);
    });

    test('defaults category to system for unknown value', () {
      final json = {
        'id': 'n2',
        'title': 'Test',
        'body': 'Body',
        'category': 'unknown_category',
        'created_at': '2025-01-15T10:00:00Z',
      };

      final notif = AppNotification.fromJson(json);
      expect(notif.category, NotificationCategory.system);
    });

    test('defaults isRead to false', () {
      final json = {
        'id': 'n3',
        'title': 'Test',
        'body': 'Body',
        'created_at': '2025-01-15T10:00:00Z',
      };

      final notif = AppNotification.fromJson(json);
      expect(notif.isRead, isFalse);
    });

    test('parses all category values', () {
      for (final cat in NotificationCategory.values) {
        final json = {
          'id': 'n_$cat',
          'title': 'T',
          'body': 'B',
          'category': cat.name,
          'created_at': '2025-01-15T10:00:00Z',
        };
        expect(AppNotification.fromJson(json).category, cat);
      }
    });
  });

  group('AppNotification.copyWith', () {
    test('changes isRead', () {
      final notif = AppNotification(
        id: 'n1',
        title: 'Title',
        body: 'Body',
        category: NotificationCategory.points,
        createdAt: DateTime(2025, 1, 15),
      );

      final updated = notif.copyWith(isRead: true);
      expect(updated.isRead, isTrue);
      expect(updated.id, 'n1');
      expect(updated.title, 'Title');
      expect(updated.category, NotificationCategory.points);
    });
  });
}
