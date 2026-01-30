import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/checkin/data/checkin_repository.dart';
import 'package:vigilo/features/checkin/domain/models/shift_checkin.dart';
import 'package:vigilo/features/profile/domain/models/user_profile.dart';
import 'package:vigilo/features/profile/providers/profile_providers.dart';

/// Repository provider.
final checkinRepositoryProvider = Provider<CheckinRepository>((ref) {
  return CheckinRepository(ref.watch(supabaseClientProvider));
});

/// Provider asincrono per lo stato del check-in odierno.
final todayCheckinProvider =
    AsyncNotifierProvider<TodayCheckinNotifier, ShiftCheckin>(
  TodayCheckinNotifier.new,
);

class TodayCheckinNotifier extends AsyncNotifier<ShiftCheckin> {
  @override
  Future<ShiftCheckin> build() async {
    // Recupera la categoria dal profilo
    final profileAsync = ref.read(profileProvider);
    final category = profileAsync.when(
      data: (p) => p.category,
      loading: () => WorkerCategory.operaio,
      error: (_, __) => WorkerCategory.operaio,
    );

    try {
      final repo = ref.read(checkinRepositoryProvider);
      final json = await repo.getTodayCheckin();
      final hasCheckin = json['has_checkin'] as bool? ?? false;

      if (hasCheckin) {
        return ShiftCheckin.fromJson(json, category);
      }
      // Nessun check-in oggi: ritorna pending
      return ShiftCheckin(
        workerCategory: category,
        requiredDpi: DpiRequirement.forCategory(category),
        checkedDpiIds: const {},
        status: CheckinStatus.pending,
      );
    } on Object {
      return ShiftCheckin.mockPending();
    }
  }

  /// Conferma il check-in DPI e aggiorna lo stato.
  Future<Map<String, dynamic>?> confirmCheckin(List<String> dpiIds) async {
    try {
      final repo = ref.read(checkinRepositoryProvider);
      final result = await repo.processCheckin(dpiIds);

      if (result['success'] == true) {
        // Ricarica lo stato check-in
        ref.invalidateSelf();
        await future;
      }

      return result;
    } on Object {
      return null;
    }
  }

  /// Toggle un DPI nella lista locale (pre-conferma).
  void toggleDpi(String dpiId) {
    final current = state.when(
      data: (v) => v,
      loading: () => null,
      error: (_, __) => null,
    );
    if (current == null || current.status == CheckinStatus.completed) return;
    state = AsyncValue.data(current.toggleDpi(dpiId));
  }
}
