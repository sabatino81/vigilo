import 'package:permission_handler/permission_handler.dart';

/// A small wrapper around `permission_handler` to centralize runtime
/// permission checks and requests. Keep methods small and testable.
class PermissionService {
  PermissionService._();

  /// Check whether notifications permission is granted (Android 13+)
  static Future<bool> isNotificationGranted() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  /// Request notifications permission. Returns true if granted.
  static Future<bool> requestNotification() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// Check whether external storage (read/write) is granted.
  static Future<bool> isStorageGranted() async {
    final read = await Permission.storage.status;
    // On Android 13+ you may need separate media permissions depending on usage
    return read.isGranted;
  }

  /// Request storage permission.
  static Future<bool> requestStorage() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// Utility to open app settings for the user to enable permissions.
  static Future<bool> openSettings() async {
    return openAppSettings();
  }
}
