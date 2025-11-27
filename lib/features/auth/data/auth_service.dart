import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _logger = Logger(printer: PrettyPrinter());

class AuthService {
  /// Allow injecting a GoTrueClient (from Supabase) for easier testing.
  AuthService({GoTrueClient? authClient})
    : _authClient = authClient ?? Supabase.instance.client.auth;
  final GoTrueClient _authClient;

  bool get isLoggedIn => _authClient.currentSession != null;

  Future<void> signUp(String email, String password) async {
    try {
      final res = await _authClient.signUp(email: email, password: password);
      _logger.i('User signed up: ${res.user?.email}');
    } on Exception catch (e, st) {
      _logger.e('Signup error', error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final res = await _authClient.signInWithPassword(
        email: email,
        password: password,
      );
      _logger.i('User signed in: ${res.session?.user.email}');
    } on Exception catch (e, st) {
      _logger.e('Signin error', error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authClient.signOut();
      _logger.i('User signed out');
    } on Exception catch (e, st) {
      _logger.e('Signout error', error: e, stackTrace: st);
      rethrow;
    }
  }
}
