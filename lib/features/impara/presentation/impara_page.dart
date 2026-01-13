import 'dart:async';

import 'package:flutter/material.dart';
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

/// Pagina principale Impara con formazione, video, quiz e certificazioni
class ImparaPage extends StatefulWidget {
  const ImparaPage({super.key});

  @override
  State<ImparaPage> createState() => _ImparaPageState();
}

class _ImparaPageState extends State<ImparaPage> {
  // Mock data
  final List<TrainingTodo> _todos = TrainingTodo.dailyTodos();
  final List<TrainingContent> _contents = TrainingContent.mockContents();
  final TrainingProgress _progress = TrainingProgress.mockProgress();

  void _openLibrary() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => LibraryPage(contents: _contents),
      ),
    );
  }

  void _openContent(TrainingContent content) {
    unawaited(ContentDetailSheet.show(context, content: content));
  }

  void _handleTodoTap(TrainingTodo todo) {
    if (todo.quizId != null) {
      // Apri quiz
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => QuizPage(quiz: Quiz.weeklyQuiz()),
        ),
      );
    } else if (todo.contentId != null) {
      // Apri contenuto
      final content = _contents.firstWhere(
        (c) => c.id == todo.contentId,
        orElse: () => _contents.first,
      );
      _openContent(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Contenuti suggeriti (video e lezioni non completati)
    final suggestedContents = _contents
        .where(
          (c) =>
              c.status != ContentStatus.completed &&
              (c.type == ContentType.video || c.type == ContentType.pdf),
        )
        .take(3)
        .toList();

    // Contenuti raccomandati
    final recommendedContents = _contents
        .where((c) => c.status == ContentStatus.notStarted)
        .take(3)
        .toList();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // To-Do Formativo
              TrainingTodoCard(
                todos: _todos,
                onTodoTap: _handleTodoTap,
              ),
              const SizedBox(height: 16),

              // Biblioteca Preview
              LibraryPreviewCard(
                suggestedContents: suggestedContents,
                onSearchTap: _openLibrary,
                onContentTap: _openContent,
                onViewAllTap: _openLibrary,
              ),
              const SizedBox(height: 16),

              // Progresso Formativo
              TrainingProgressCard(progress: _progress),
              const SizedBox(height: 16),

              // Consigliati per te
              RecommendedContentCard(
                contents: recommendedContents,
                onContentTap: _openContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
