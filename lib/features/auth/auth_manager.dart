import 'dart:async';

import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _authLogger = Logger(printer: PrettyPrinter());

/// Monitors Supabase session expiry and attempts an automatic refresh.
/// If refresh fails, triggers sign out to avoid using stale tokens.
/// Nota: viene usato internamente il membro deprecato `userDeleted` di
/// Supabase per compatibilità retrocompatibile; la rimozione richiede una
/// migrazione dei flussi auth. Documentiamo qui il motivo della ignore.
///
/// questo documento spiega perché sovrascriviamo il controllo del
/// warning: aggiornare o rimuovere l'ignore solo dopo aver completato la
/// migrazione dell'autenticazione a nuove API Supabase.
// Reason: legacy Supabase `userDeleted` member is used until auth flows
// are migrated to newer client APIs.

class AuthManager {
  Timer? _refreshTimer;
  StreamSubscription<dynamic>? _sub;
  // Keep a single weak-like reference to the active manager so top-level
  // helpers can call instance methods from Timer callbacks without creating
  // closures inline.
  static AuthManager? _activeInstance;

  /// How long before expiry to try a refresh (in seconds).
  final int refreshBefore = 60;

  /// Maximum number of retry attempts when refresh fails.
  final int maxRetries = 3;

  /// Delay between retries in seconds.
  final int retryDelaySeconds = 5;

  void start() {
    // register active instance for top-level timer helpers
    _activeInstance = this;
    // Listen for auth state changes to start/stop the monitor.
    _sub = Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      final e = event.event;
      final session = event.session;
      _authLogger.d('AuthManager event: $e');

      if (e == AuthChangeEvent.signedIn ||
          e == AuthChangeEvent.initialSession ||
          e == AuthChangeEvent.tokenRefreshed) {
        _scheduleRefresh(session);
      } else if (e == AuthChangeEvent.signedOut ||
          // Legacy Supabase enum used for older clients; kept for
          // backwards compatibility until auth flows are migrated.
          // ignore: deprecated_member_use
          e == AuthChangeEvent.userDeleted) {
        _cancelRefresh();
      }
    });

    // If there's an existing session at startup, schedule refresh.
    final current = Supabase.instance.client.auth.currentSession;
    if (current != null) _scheduleRefresh(current);
  }

  Future<void> stop() async {
    _cancelRefresh();
    await _sub?.cancel();
    _sub = null;
    if (identical(_activeInstance, this)) _activeInstance = null;
  }

  void _cancelRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  void _scheduleRefresh(Session? session) {
    _cancelRefresh();
    if (session == null) return;

    try {
      final expiresAt = session.expiresAt; // int? seconds since epoch
      if (expiresAt == null) return;
      final expiry = DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);
      final now = DateTime.now();
      final refreshAt = expiry.subtract(Duration(seconds: refreshBefore));
      var delay = refreshAt.difference(now);
      if (delay.isNegative) {
        // already expired or very close — try refresh immediately
        delay = Duration.zero;
      }

      _authLogger.i(
        'Scheduling token refresh in ${delay.inSeconds}s '
        '(expiry: $expiry)',
      );
      // Use a top-level helper to allow using a tearoff-like invocation from
      // the Timer without creating an anonymous closure here.
      _refreshTimer = Timer(delay, _invokeDoRefreshFromTimer);
    } on Object catch (e, st) {
      _authLogger.e(
        'Failed scheduling refresh',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _doRefresh() async {
    _authLogger.i('Attempting token refresh');

    var attempt = 0;
    while (attempt < maxRetries) {
      attempt++;
      try {
        final res = await Supabase.instance.client.auth.refreshSession();
        _authLogger.i('Refresh attempt $attempt result: $res');

        final current = Supabase.instance.client.auth.currentSession;
        if (current != null) {
          // Success — schedule next refresh based on new session.
          _scheduleRefresh(current);
          return;
        }

        _authLogger.w('Refresh did not yield a session on attempt $attempt');
      } on Object catch (e, st) {
        _authLogger.w(
          'Refresh attempt $attempt failed',
          error: e,
          stackTrace: st,
        );
      }

      if (attempt < maxRetries) {
        _authLogger.i(
          'Retrying refresh in ${retryDelaySeconds}s '
          '(attempt $attempt of $maxRetries)',
        );
        await Future<void>.delayed(Duration(seconds: retryDelaySeconds));
      }
    }

    // If we reached here, all attempts failed — sign out to clear state.
    _authLogger.e('All refresh attempts failed — signing out');
    try {
      await Supabase.instance.client.auth.signOut();
    } on Object catch (_) {}
  }

  /// Public wrapper so the top-level timer helper can request a refresh on
  /// the current active instance without requiring an inline closure.
  Future<void> invokeDoRefresh() async => _doRefresh();
}

// Top-level helper used as a Timer callback. It forwards the call to the
// active AuthManager instance and intentionally discards the returned
// Future (the Timer API expects a void callback).
void _invokeDoRefreshFromTimer() {
  // Reason: the Timer API requires a void callback; we intentionally
  // discard the returned Future from the async handler here.
  // ignore: discarded_futures
  AuthManager._activeInstance?.invokeDoRefresh();
}
