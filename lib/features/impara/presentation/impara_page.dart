import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/features/impara/domain/models/certificate.dart';
import 'package:vigilo/features/impara/domain/models/quiz.dart';
import 'package:vigilo/features/impara/domain/models/training_content.dart';
import 'package:vigilo/features/impara/domain/models/training_todo.dart';
import 'package:vigilo/features/impara/presentation/pages/content_detail_sheet.dart';
import 'package:vigilo/features/impara/presentation/pages/library_page.dart';
import 'package:vigilo/features/impara/presentation/pages/quiz_page.dart';
import 'package:vigilo/features/impara/presentation/widgets/library_preview_card.dart';
import 'package:vigilo/features/impara/presentation/widgets/recommended_content_card.dart';
import 'package:vigilo/features/impara/presentation/widgets/training_progress_card.dart';
import 'package:vigilo/features/impara/presentation/widgets/training_todo_card.dart';
import 'package:vigilo/features/impara/providers/impara_providers.dart';

/// Pagina principale Impara — ConsumerWidget con dati da Supabase.
class ImparaPage extends ConsumerWidget {
  const ImparaPage({super.key});

  void _openLibrary(BuildContext context, List<TrainingContent> contents) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => LibraryPage(contents: contents),
      ),
    );
  }

  void _openContent(BuildContext context, TrainingContent content) {
    unawaited(ContentDetailSheet.show(context, content: content));
  }

  void _handleTodoTap(
    BuildContext context,
    TrainingTodo todo,
    List<TrainingContent> contents,
  ) {
    if (todo.quizId != null) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => QuizPage(quiz: Quiz.weeklyQuiz()),
        ),
      );
    } else if (todo.contentId != null) {
      final content = contents.firstWhere(
        (c) => c.id == todo.contentId,
        orElse: () => contents.first,
      );
      _openContent(context, content);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentsAsync = ref.watch(trainingContentsProvider);
    final progressAsync = ref.watch(trainingProgressProvider);

    // TrainingTodo non ha tabella DB — resta mock
    final todos = TrainingTodo.dailyTodos();

    // Estrai dati con fallback
    final contents = contentsAsync.when(
      data: (c) => c,
      loading: () => <TrainingContent>[],
      error: (_, __) => <TrainingContent>[],
    );
    final progress = progressAsync.when(
      data: (p) => p,
      loading: () => null,
      error: (_, __) => null,
    );

    // Contenuti suggeriti (video e lezioni non completati)
    final suggestedContents = contents
        .where(
          (c) =>
              c.status != ContentStatus.completed &&
              (c.type == ContentType.video || c.type == ContentType.pdf),
        )
        .take(3)
        .toList();

    // Contenuti raccomandati
    final recommendedContents = contents
        .where((c) => c.status == ContentStatus.notStarted)
        .take(3)
        .toList();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(trainingContentsProvider);
          ref.invalidate(trainingProgressProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // To-Do Formativo
              TrainingTodoCard(
                todos: todos,
                onTodoTap: (todo) =>
                    _handleTodoTap(context, todo, contents),
              ),
              const SizedBox(height: 16),

              // Biblioteca Preview
              LibraryPreviewCard(
                suggestedContents: suggestedContents,
                onSearchTap: () => _openLibrary(context, contents),
                onContentTap: (c) => _openContent(context, c),
                onViewAllTap: () => _openLibrary(context, contents),
              ),
              const SizedBox(height: 16),

              // Progresso Formativo
              if (progress != null)
                TrainingProgressCard(progress: progress),
              if (progress != null) const SizedBox(height: 16),

              // Consigliati per te
              if (recommendedContents.isNotEmpty)
                RecommendedContentCard(
                  contents: recommendedContents,
                  onContentTap: (c) => _openContent(context, c),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
