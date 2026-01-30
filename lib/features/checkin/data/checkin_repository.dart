import 'package:vigilo/core/data/base_repository.dart';

/// Repository per check-in DPI giornaliero via Supabase RPC.
class CheckinRepository extends BaseRepository {
  const CheckinRepository(super.client);

  /// Stato del check-in odierno.
  Future<Map<String, dynamic>> getTodayCheckin() async {
    return await rpc<Map<String, dynamic>>('get_today_checkin');
  }

  /// Conferma check-in DPI. Aggiorna streak e assegna punti.
  Future<Map<String, dynamic>> processCheckin(List<String> checkedDpiIds) async {
    return await rpc<Map<String, dynamic>>(
      'process_checkin',
      params: {'p_checked_dpi_ids': checkedDpiIds},
    );
  }
}
