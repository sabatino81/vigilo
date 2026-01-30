import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/impara/domain/models/quiz.dart';

/// Repository per quiz formativi via Supabase RPC.
class QuizRepository extends BaseRepository {
  const QuizRepository(super.client);

  /// Lista quiz disponibili con domande.
  Future<List<Quiz>> getQuizzes({String? category}) async {
    final json = await rpc<List<dynamic>>(
      'get_quizzes',
      params: {
        if (category != null) 'p_category': category,
      },
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(Quiz.fromJson)
        .toList();
  }

  /// Invia risultato quiz. Ritorna score + punti assegnati.
  Future<Map<String, dynamic>> submitQuizResult({
    required String quizId,
    required List<int> answers,
  }) async {
    return await rpc<Map<String, dynamic>>(
      'submit_quiz_result',
      params: {
        'p_quiz_id': quizId,
        'p_answers': answers,
      },
    );
  }

  /// Storico risultati quiz dell'utente.
  Future<List<QuizResult>> getMyQuizResults({
    int limit = 20,
    int offset = 0,
  }) async {
    final json = await rpc<List<dynamic>>(
      'get_my_quiz_results',
      params: {'p_limit': limit, 'p_offset': offset},
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(QuizResult.fromJson)
        .toList();
  }
}
