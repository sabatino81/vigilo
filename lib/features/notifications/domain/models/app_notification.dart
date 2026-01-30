import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Categoria notifica
enum NotificationCategory {
  safety,
  points,
  team,
  system;

  String get label {
    switch (this) {
      case NotificationCategory.safety:
        return 'Sicurezza';
      case NotificationCategory.points:
        return 'Punti';
      case NotificationCategory.team:
        return 'Team';
      case NotificationCategory.system:
        return 'Sistema';
    }
  }

  String get labelEn {
    switch (this) {
      case NotificationCategory.safety:
        return 'Safety';
      case NotificationCategory.points:
        return 'Points';
      case NotificationCategory.team:
        return 'Team';
      case NotificationCategory.system:
        return 'System';
    }
  }

  Color get color {
    switch (this) {
      case NotificationCategory.safety:
        return AppTheme.danger;
      case NotificationCategory.points:
        return AppTheme.ambra;
      case NotificationCategory.team:
        return AppTheme.tertiary;
      case NotificationCategory.system:
        return AppTheme.neutral;
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationCategory.safety:
        return Icons.health_and_safety_rounded;
      case NotificationCategory.points:
        return Icons.stars_rounded;
      case NotificationCategory.team:
        return Icons.groups_rounded;
      case NotificationCategory.system:
        return Icons.settings_rounded;
    }
  }
}

/// Notifica app
class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.createdAt,
    this.isRead = false,
  });

  final String id;
  final String title;
  final String body;
  final NotificationCategory category;
  final DateTime createdAt;
  final bool isRead;

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      category: category,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  /// Mock data: 10 notifiche
  static List<AppNotification> mockNotifications() {
    final now = DateTime.now();
    return [
      AppNotification(
        id: 'n1',
        title: 'Nuova sfida team!',
        body: 'La sfida "Zero Incidenti" inizia oggi. '
            'Partecipa con il tuo team!',
        category: NotificationCategory.team,
        createdAt: now.subtract(const Duration(minutes: 30)),
      ),
      AppNotification(
        id: 'n2',
        title: '+50 Punti Elmetto',
        body: 'Hai completato il quiz settimanale sulla sicurezza.',
        category: NotificationCategory.points,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      AppNotification(
        id: 'n3',
        title: 'Segnalazione approvata',
        body: 'La tua segnalazione NM-2025-00123 e stata '
            'verificata e approvata.',
        category: NotificationCategory.safety,
        createdAt: now.subtract(const Duration(hours: 5)),
        isRead: true,
      ),
      AppNotification(
        id: 'n4',
        title: 'Streak 14 giorni!',
        body: 'Ottimo lavoro! 14 giorni consecutivi di '
            'check-in. Continua cosi!',
        category: NotificationCategory.points,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      AppNotification(
        id: 'n5',
        title: 'Ordine spedito',
        body: 'Il tuo ordine VIG-2025-00142 e stato spedito. '
            'Tracking: CJ1234567890IT',
        category: NotificationCategory.system,
        createdAt: now.subtract(const Duration(days: 1, hours: 3)),
        isRead: true,
      ),
      AppNotification(
        id: 'n6',
        title: 'Nuovo corso disponibile',
        body: 'Il corso "Gestione Emergenze 2025" e ora '
            'disponibile nella sezione Impara.',
        category: NotificationCategory.team,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      AppNotification(
        id: 'n7',
        title: 'Welfare aziendale attivo',
        body: 'La tua azienda ha attivato il welfare. '
            'Sconto fino al 100% sullo Spaccio Aziendale!',
        category: NotificationCategory.system,
        createdAt: now.subtract(const Duration(days: 3)),
        isRead: true,
      ),
      AppNotification(
        id: 'n8',
        title: 'Allerta meteo sede operativa',
        body: 'Domani previste raffiche di vento >60km/h. '
            'Lavori in quota sospesi.',
        category: NotificationCategory.safety,
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      AppNotification(
        id: 'n9',
        title: 'DPI in scadenza',
        body: 'Le scarpe antinfortunistiche risultano '
            'vicine alla data di sostituzione.',
        category: NotificationCategory.safety,
        createdAt: now.subtract(const Duration(days: 5)),
        isRead: true,
      ),
      AppNotification(
        id: 'n10',
        title: 'Benvenuto su Vigilo!',
        body: 'Completa il tuo primo check-in per iniziare '
            'a guadagnare Punti Elmetto.',
        category: NotificationCategory.system,
        createdAt: now.subtract(const Duration(days: 7)),
        isRead: true,
      ),
    ];
  }
}
