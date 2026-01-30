import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/sos/data/emergency_contact_repository.dart';
import 'package:vigilo/features/sos/data/safety_report_repository.dart';
import 'package:vigilo/features/sos/domain/models/emergency_contact.dart';
import 'package:vigilo/features/sos/domain/models/safety_report.dart';

// ============================================================
// Repository providers
// ============================================================

final safetyReportRepositoryProvider = Provider<SafetyReportRepository>((ref) {
  return SafetyReportRepository(ref.watch(supabaseClientProvider));
});

final emergencyContactRepositoryProvider =
    Provider<EmergencyContactRepository>((ref) {
  return EmergencyContactRepository(ref.watch(supabaseClientProvider));
});

// ============================================================
// Safety reports provider (storico segnalazioni)
// ============================================================

final safetyReportsProvider =
    AsyncNotifierProvider<SafetyReportsNotifier, List<SafetyReport>>(
  SafetyReportsNotifier.new,
);

class SafetyReportsNotifier extends AsyncNotifier<List<SafetyReport>> {
  @override
  Future<List<SafetyReport>> build() async {
    try {
      final repo = ref.read(safetyReportRepositoryProvider);
      return await repo.getMyReports();
    } on Object {
      return SafetyReport.mockReports();
    }
  }

  /// Invia una nuova segnalazione e ricarica la lista.
  Future<Map<String, dynamic>?> submitReport({
    required String type,
    required String description,
    String? locationName,
    double? latitude,
    double? longitude,
    bool contactRequested = false,
  }) async {
    try {
      final repo = ref.read(safetyReportRepositoryProvider);
      final result = await repo.submitReport(
        type: type,
        description: description,
        locationName: locationName,
        latitude: latitude,
        longitude: longitude,
        contactRequested: contactRequested,
      );

      if (result['success'] == true) {
        ref.invalidateSelf();
        await future;
      }

      return result;
    } on Object {
      return null;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(safetyReportRepositoryProvider);
      return repo.getMyReports();
    });
  }
}

// ============================================================
// Emergency contacts provider
// ============================================================

final emergencyContactsProvider =
    AsyncNotifierProvider<EmergencyContactsNotifier, List<EmergencyContact>>(
  EmergencyContactsNotifier.new,
);

class EmergencyContactsNotifier
    extends AsyncNotifier<List<EmergencyContact>> {
  @override
  Future<List<EmergencyContact>> build() async {
    try {
      final repo = ref.read(emergencyContactRepositoryProvider);
      return await repo.getMyContacts();
    } on Object {
      return EmergencyContact.mockContacts();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(emergencyContactRepositoryProvider);
      return repo.getMyContacts();
    });
  }
}
