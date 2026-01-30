import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/impara/domain/models/certificate.dart';
import 'package:vigilo/features/impara/domain/models/training_content.dart';

/// Repository per contenuti formativi via Supabase RPC.
class TrainingRepository extends BaseRepository {
  const TrainingRepository(super.client);

  /// Lista contenuti formativi con progresso utente.
  Future<List<TrainingContent>> getTrainingContents({
    String? category,
  }) async {
    final json = await rpc<List<dynamic>>(
      'get_training_contents',
      params: {
        if (category != null) 'p_category': category,
      },
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(TrainingContent.fromJson)
        .toList();
  }

  /// Aggiorna progresso su un contenuto formativo.
  Future<Map<String, dynamic>> updateProgress({
    required String contentId,
    String status = 'inProgress',
    double progress = 0.0,
    bool? isFavorite,
  }) async {
    return await rpc<Map<String, dynamic>>(
      'update_training_progress',
      params: {
        'p_content_id': contentId,
        'p_status': status,
        'p_progress': progress,
        if (isFavorite != null) 'p_is_favorite': isFavorite,
      },
    );
  }

  /// Riepilogo progresso formativo (moduli + certificati).
  Future<TrainingProgress> getMyTrainingProgress() async {
    final json =
        await rpc<Map<String, dynamic>>('get_my_training_progress');
    return TrainingProgress.fromJson(json);
  }
}
