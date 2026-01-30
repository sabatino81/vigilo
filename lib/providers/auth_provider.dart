import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Stream di cambiamenti sessione auth Supabase.
///
/// Emette [AuthState] ad ogni evento (signedIn, signedOut, tokenRefreshed, etc).
/// I widget possono usare `ref.watch(authStateProvider)` per reagire ai cambi.
final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

/// ID dell'utente corrente, o `null` se non autenticato.
///
/// Derivato da [authStateProvider]: si aggiorna automaticamente quando
/// la sessione cambia.
final currentUserIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.whenOrNull(data: (state) => state.session?.user.id);
});

/// Indica se l'utente è attualmente autenticato.
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(currentUserIdProvider) != null;
});

/// Provider legacy per compatibilità con il vecchio AuthNotifier.
///
/// Mantiene l'interfaccia `signIn()`/`signOut()` per i widget che la usano,
/// ma il valore è derivato dallo stato reale di Supabase.
class AuthNotifier extends Notifier<bool> {
  @override
  bool build() {
    // Sincronizza con lo stato reale di Supabase
    return ref.watch(isAuthenticatedProvider);
  }

  Future<void> signIn() async {
    // I widget che chiamano signIn() dovrebbero usare AuthService.signIn()
    // e poi lo stato si aggiorna automaticamente via authStateProvider.
    state = true;
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    state = false;
  }
}

final authProvider = NotifierProvider<AuthNotifier, bool>(AuthNotifier.new);
