import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/data/supabase_provider.dart';
import 'package:vigilo/features/impara/data/quiz_repository.dart';
import 'package:vigilo/features/impara/data/training_repository.dart';
import 'package:vigilo/features/impara/domain/models/certificate.dart';
import 'package:vigilo/features/impara/domain/models/quiz.dart';
import 'package:vigilo/features/impara/domain/models/training_content.dart';

// ============================================================
// Repository providers
// ============================================================

final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  return TrainingRepository(ref.watch(supabaseClientProvider));
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepository(ref.watch(supabaseClientProvider));
});

// ============================================================
// Training contents provider
// ============================================================

final trainingContentsProvider =
    AsyncNotifierProvider<TrainingContentsNotifier, List<TrainingContent>>(
  TrainingContentsNotifier.new,
);

class TrainingContentsNotifier extends AsyncNotifier<List<TrainingContent>> {
  @override
  Future<List<TrainingContent>> build() async {
    try {
      final repo = ref.read(trainingRepositoryProvider);
      return await repo.getTrainingContents();
    } on Object {
      return TrainingContent.mockContents();
    }
  }

  /// Aggiorna progresso su un contenuto.
  Future<Map<String, dynamic>?> updateProgress({
    required String contentId,
    String status = 'inProgress',
    double progress = 0.0,
    bool? isFavorite,
  }) async {
    try {
      final repo = ref.read(trainingRepositoryProvider);
      final result = await repo.updateProgress(
        contentId: contentId,
        status: status,
        progress: progress,
        isFavorite: isFavorite,
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
      final repo = ref.read(trainingRepositoryProvider);
      return repo.getTrainingContents();
    });
  }
}

// ============================================================
// Training progress provider (riepilogo)
// ============================================================

final trainingProgressProvider =
    AsyncNotifierProvider<TrainingProgressNotifier, TrainingProgress>(
  TrainingProgressNotifier.new,
);

class TrainingProgressNotifier extends AsyncNotifier<TrainingProgress> {
  @override
  Future<TrainingProgress> build() async {
    try {
      final repo = ref.read(trainingRepositoryProvider);
      return await repo.getMyTrainingProgress();
    } on Object {
      return TrainingProgress.mockProgress();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(trainingRepositoryProvider);
      return repo.getMyTrainingProgress();
    });
  }
}

// ============================================================
// Quizzes provider
// ============================================================

final quizzesProvider =
    AsyncNotifierProvider<QuizzesNotifier, List<Quiz>>(
  QuizzesNotifier.new,
);

class QuizzesNotifier extends AsyncNotifier<List<Quiz>> {
  @override
  Future<List<Quiz>> build() async {
    try {
      final repo = ref.read(quizRepositoryProvider);
      return await repo.getQuizzes();
    } on Object {
      return [Quiz.weeklyQuiz()];
    }
  }

  /// Invia risultato quiz.
  Future<Map<String, dynamic>?> submitResult({
    required String quizId,
    required List<int> answers,
  }) async {
    try {
      final repo = ref.read(quizRepositoryProvider);
      return await repo.submitQuizResult(
        quizId: quizId,
        answers: answers,
      );
    } on Object {
      return null;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(quizRepositoryProvider);
      return repo.getQuizzes();
    });
  }
}

// ============================================================
// Quiz results provider (storico)
// ============================================================

final quizResultsProvider =
    AsyncNotifierProvider<QuizResultsNotifier, List<QuizResult>>(
  QuizResultsNotifier.new,
);

class QuizResultsNotifier extends AsyncNotifier<List<QuizResult>> {
  @override
  Future<List<QuizResult>> build() async {
    try {
      final repo = ref.read(quizRepositoryProvider);
      return await repo.getMyQuizResults();
    } on Object {
      return [];
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(quizRepositoryProvider);
      return repo.getMyQuizResults();
    });
  }
}
