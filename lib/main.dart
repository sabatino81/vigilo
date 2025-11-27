import 'package:flutter/material.dart';
import 'package:vigilo/core/env/env.dart';
import 'package:vigilo/core/router/app_router.dart';
import 'package:vigilo/core/storage/hive_storage.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/auth/auth_manager.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';
import 'package:vigilo/providers/locale_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ... helper files are present in lib/core and lib/features but not imported here to avoid unused-import warnings
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Logger centralizzato (spostato in cima per essere disponibile durante
/// l'inizializzazione prima che qualsiasi funzione lo usi).
final logger = Logger(printer: PrettyPrinter());

/// Nota: il progetto ancora utilizza il membro `userDeleted` di Supabase.
/// Questo è un caso conosciuto e documentato: rimuovere questa ignoranza
/// richiede una migrazione dei flussi di autenticazione a versioni più
/// recenti del client Supabase. Per chiarezza è mantenuta la documentazione
/// qui (diagnostica `deprecated_member_use`).

// Documented ignores for file:
// - cascade_invocations: nested widget constructors are intentional and
//   clearer as nested children rather than using cascades.
// - deprecated_member_use: legacy Supabase enum member is used until auth
//   flows are migrated to newer Supabase client APIs.
// ignore_for_file: cascade_invocations, deprecated_member_use

// Nota: usiamo direttamente `Supabase.instance.client` nel codice del progetto.
// Il getter globale `supabase` non era riferito e causava un warning di
// "unreachable member". Rimosso per chiarezza.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables from assets (intentionally empty placeholders)
  // and then fallback to filesystem .env.<flavor> or .env for local secrets.
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  final assetEnv = 'assets/env/.env.$flavor';
  try {
    await dotenv.load(fileName: assetEnv);
    logger.i('Loaded env asset: $assetEnv');
  } on Object catch (e, s) {
    logger.w('dotenv asset load error for $assetEnv; continuing.');
    logger.d('dotenv asset load error', error: e, stackTrace: s);
  }

  // Init Hive for local cache/storage
  await HiveStorage.init();

  // Helper to safely read dotenv keys without throwing if dotenv was
  // never initialized. flutter_dotenv throws NotInitializedError when
  // accessed before load(), so we catch any error and return null.
  String? safeMaybeGet(String key) {
    try {
      return dotenv.maybeGet(key);
    } on Object catch (e, s) {
      logger.d(
        'dotenv not initialized when reading $key',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  // Read env keys only after all load attempts (asset + filesystem
  // fallback). This prevents NotInitializedError when dotenv.load didn't
  // run successfully.
  var supabaseConfigured = true;
  var supabaseUrl = safeMaybeGet('SUPABASE_URL');
  var supabaseAnon = safeMaybeGet('SUPABASE_ANON_KEY');

  if (supabaseUrl == null ||
      supabaseUrl.isEmpty ||
      supabaseAnon == null ||
      supabaseAnon.isEmpty) {
    // The asset did not contain SUPABASE keys. Try loading a local file
    // fallback: first `.env`, then `.env.<flavor>` (only useful during
    // development; these files should be uncommitted).
    logger.w(
      'SUPABASE keys not found in asset; attempting filesystem fallback',
    );
    try {
      // Try base `.env` first
      await dotenv.load();
      logger.i('Loaded fallback .env from filesystem');
    } on Object catch (_) {
      try {
        const fallback = '.env.$flavor';
        await dotenv.load(fileName: fallback);
        logger.i('Loaded fallback $fallback from filesystem');
      } on Object catch (e, s) {
        logger.w(
          'No local .env found; proceeding without environment overrides.',
        );
        logger.d('dotenv fallback load error', error: e, stackTrace: s);
      }
    }

    // Re-read keys after fallback attempt
    supabaseUrl = safeMaybeGet('SUPABASE_URL');
    supabaseAnon = safeMaybeGet('SUPABASE_ANON_KEY');
    if (supabaseUrl == null ||
        supabaseUrl.isEmpty ||
        supabaseAnon == null ||
        supabaseAnon.isEmpty) {
      logger.w(
        'Missing SUPABASE_URL or SUPABASE_ANON_KEY in env after fallback.',
      );
      supabaseConfigured = false;
    } else {
      supabaseConfigured = true;
    }

    // Diagnostic logging: where did the SUPABASE values come from?
    try {
      final anon = supabaseAnon ?? '';
      final anonMasked = anon.length >= 8
          ? '${anon.substring(0, 4)}...${anon.substring(anon.length - 4)}'
          : '***';
      if (supabaseConfigured) {
        logger.i('Supabase keys found (masked anon): $anonMasked');
      } else {
        logger.w('Supabase keys not configured after fallback');
      }
    } on Object catch (e, s) {
      logger.d(
        'Error while logging supabase diagnostic',
        error: e,
        stackTrace: s,
      );
    }
  }

  // Supabase: initialize only if configured
  if (supabaseConfigured) {
    // Use Env.requireEnv to provide a clear error when keys are missing in
    // production-like environments.
    final url = Env.requireEnv('SUPABASE_URL');
    final anon = Env.requireEnv('SUPABASE_ANON_KEY');
    await Supabase.initialize(
      url: url,
      anonKey: anon,
    );
  }

  // Start auth manager (refresh tokens / auto signout) ONLY if Supabase
  // was initialized. If Supabase isn't configured we must not touch its
  // singleton (it would throw _isInitialized assertion).
  AuthManager? authManager;
  if (supabaseConfigured) {
    authManager = AuthManager();
    authManager.start();
  }

  // Run app
  runApp(ProviderScope(child: MyApp(supabaseConfigured: supabaseConfigured)));

  // Register auth state listener only if Supabase is configured. The
  // listener accesses `Supabase.instance` and would fail otherwise.
  if (supabaseConfigured) {
    authStateListener();
  }
}

/// App
class MyApp extends ConsumerWidget {
  // Constructor should appear before other members to satisfy the
  // `sort_constructors_first` lint.
  const MyApp({super.key, this.supabaseConfigured = true});

  final bool supabaseConfigured;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    if (!supabaseConfigured) {
      // show a minimal MaterialApp with a helpful configuration error page
      return MaterialApp(
        title: 'Vigilo - Missing Config',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const Scaffold(
          body: Center(
            child: Text('Configuration missing. See README for setup.'),
          ),
        ),
      );
    }

    return MaterialApp.router(
      title: 'Vigilo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter.router,
    );
  }
}

// Note: previous example home widget removed in favor of routed pages.

// Logger is declared at the top of the file.

/// Listener cambi stato auth — tutti i casi enumerati
void authStateListener() {
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final event = data.event;
    final session = data.session;

    switch (event) {
      case AuthChangeEvent.initialSession:
        logger.d('Auth event: initialSession');
      case AuthChangeEvent.passwordRecovery:
        logger.w('Auth event: passwordRecovery');
      case AuthChangeEvent.signedIn:
        logger.i('Auth event: signedIn -> ${session?.user.email}');
      case AuthChangeEvent.signedOut:
        logger.w('Auth event: signedOut');
      case AuthChangeEvent.tokenRefreshed:
        logger.i('Auth event: tokenRefreshed');
      case AuthChangeEvent.userUpdated:
        logger.i('Auth event: userUpdated');
      case AuthChangeEvent.userDeleted:
        logger.w('Auth event: userDeleted');
      case AuthChangeEvent.mfaChallengeVerified:
        logger.i('Auth event: mfaChallengeVerified');
    }
  });
}
