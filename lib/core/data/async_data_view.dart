import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget helper per gestire [AsyncValue] da Riverpod.
///
/// Mostra automaticamente loading, errore o dati in base allo stato.
/// Supporta pull-to-refresh tramite [onRefresh].
class AsyncDataView<T> extends StatelessWidget {
  const AsyncDataView({
    required this.value,
    required this.builder,
    this.onRefresh,
    this.loadingWidget,
    this.errorBuilder,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) builder;
  final Future<void> Function()? onRefresh;
  final Widget? loadingWidget;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () =>
          loadingWidget ??
          const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          errorBuilder?.call(error, stackTrace) ??
          _DefaultErrorView(
            error: error,
            onRetry: onRefresh,
          ),
      data: (data) {
        final child = builder(data);
        if (onRefresh != null) {
          return RefreshIndicator(
            onRefresh: onRefresh!,
            child: child,
          );
        }
        return child;
      },
    );
  }
}

class _DefaultErrorView extends StatelessWidget {
  const _DefaultErrorView({required this.error, this.onRetry});

  final Object error;
  final Future<void> Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Si è verificato un errore',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Riprova'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
