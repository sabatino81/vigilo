import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/impara/domain/models/training_todo.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

/// Card To-Do Formativo del giorno
class TrainingTodoCard extends StatelessWidget {
  const TrainingTodoCard({
    required this.todos,
    this.onTodoTap,
    super.key,
  });

  final List<TrainingTodo> todos;
  final void Function(TrainingTodo)? onTodoTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.checklist_rounded,
                  color: AppTheme.tertiary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.imparaTrainingTodo,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Lista to-do
          ...todos.map(
            (todo) => _TodoItem(
              todo: todo,
              isDark: isDark,
              onTap: () => onTodoTap?.call(todo),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodoItem extends StatelessWidget {
  const _TodoItem({
    required this.todo,
    required this.isDark,
    this.onTap,
  });

  final TrainingTodo todo;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: todo.isCompleted
            ? Border.all(
                color: AppTheme.secondary.withValues(alpha: 0.3),
              )
            : null,
      ),
      child: Row(
        children: [
          // Icona tipo
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: todo.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              todo.icon,
              color: todo.color,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                    decoration:
                        todo.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 2),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (todo.durationMinutes != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 12,
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${todo.durationMinutes} min',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.bolt_rounded,
                          size: 12,
                          color: AppTheme.primary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '+${todo.points} pt',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bottone azione
          if (!todo.isCompleted)
            FilledButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                onTap?.call();
              },
              style: FilledButton.styleFrom(
                backgroundColor: todo.color,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                todo.actionLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppTheme.secondary,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
