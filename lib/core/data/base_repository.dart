import 'package:supabase_flutter/supabase_flutter.dart';

/// Classe base per tutti i repository che accedono a Supabase.
///
/// Fornisce accesso al [SupabaseClient] e helper comuni per le chiamate RPC.
abstract class BaseRepository {
  const BaseRepository(this.client);

  final SupabaseClient client;

  /// Chiama una RPC function e ritorna il risultato decodificato.
  ///
  /// [functionName] nome della funzione PostgreSQL.
  /// [params] parametri opzionali da passare alla funzione.
  Future<T> rpc<T>(String functionName, {Map<String, dynamic>? params}) async {
    final response = await client.rpc(functionName, params: params);
    return response as T;
  }
}
