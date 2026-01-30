import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provider globale per [SupabaseClient].
///
/// Utilizzato da tutti i repository per accedere al client Supabase.
/// Richiede che [Supabase.initialize] sia stato chiamato prima dell'uso.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});
