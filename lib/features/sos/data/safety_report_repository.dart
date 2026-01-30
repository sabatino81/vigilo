import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/sos/domain/models/safety_report.dart';

/// Repository per segnalazioni sicurezza via Supabase RPC.
class SafetyReportRepository extends BaseRepository {
  const SafetyReportRepository(super.client);

  /// Invia una segnalazione. Ritorna report_code + punti assegnati.
  Future<Map<String, dynamic>> submitReport({
    required String type,
    required String description,
    String? locationName,
    double? latitude,
    double? longitude,
    bool contactRequested = false,
  }) async {
    return await rpc<Map<String, dynamic>>(
      'submit_safety_report',
      params: {
        'p_type': type,
        'p_description': description,
        if (locationName != null) 'p_location_name': locationName,
        if (latitude != null) 'p_latitude': latitude,
        if (longitude != null) 'p_longitude': longitude,
        'p_contact_requested': contactRequested,
      },
    );
  }

  /// Storico segnalazioni dell'utente.
  Future<List<SafetyReport>> getMyReports({
    int limit = 20,
    int offset = 0,
  }) async {
    final json = await rpc<List<dynamic>>(
      'get_my_reports',
      params: {'p_limit': limit, 'p_offset': offset},
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(SafetyReport.fromJson)
        .toList();
  }
}
