import 'package:vigilo/features/auth/presentation/login_page.dart';
import 'package:vigilo/features/home/presentation/home_page.dart';
import 'package:vigilo/features/splash/presentation/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  static GoRouter get router {
    // If Supabase is initialized we can read the current session and
    // choose the initial route accordingly (login if no session,
    // home otherwise). If Supabase hasn't been initialized yet we
    // default to the splash route which handles the bootstrap.
    var initial = '/splash';
    try {
      final session = Supabase.instance.client.auth.currentSession;
      initial = session == null ? '/login' : '/home';
    } on Object {
      initial = '/splash';
    }

    return GoRouter(
      initialLocation: initial,
      routes: <GoRoute>[
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
      ],
    );
  }
}
