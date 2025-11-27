import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  /// Safely read an env var using dotenv.maybeGet and catch cases where
  /// dotenv wasn't initialized yet.
  static String? _safeGet(String key) {
    try {
      return dotenv.maybeGet(key);
    } on Object {
      return null;
    }
  }

  /// Safe nullable accessors. Use these and handle nulls at the call site.
  static String? get supabaseUrl => _safeGet('SUPABASE_URL');
  static String? get supabaseKey => _safeGet('SUPABASE_ANON_KEY');

  /// Require an env variable or throw a descriptive [ArgumentError].
  static String requireEnv(String key) {
    final v = _safeGet(key);
    if (v == null || v.isEmpty) {
      throw ArgumentError('Missing required environment variable: $key');
    }
    return v;
  }
}
