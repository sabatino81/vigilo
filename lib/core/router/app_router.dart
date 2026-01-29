import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vigilo/features/auth/presentation/login_page.dart';
import 'package:vigilo/features/notifications/presentation/pages/notifications_page.dart';
import 'package:vigilo/features/profile/presentation/pages/profile_page.dart';
import 'package:vigilo/features/shop/presentation/pages/cart_page.dart';
import 'package:vigilo/features/shop/presentation/pages/checkout_page.dart';
import 'package:vigilo/features/shop/presentation/pages/orders_page.dart';
import 'package:vigilo/features/shop/presentation/pages/shop_page.dart';
import 'package:vigilo/features/shell/main_shell.dart';
import 'package:vigilo/features/splash/presentation/splash_page.dart';
import 'package:vigilo/features/streak/presentation/pages/streak_detail_page.dart';
import 'package:vigilo/features/team_challenge/presentation/pages/challenge_detail_page.dart';

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
          builder: (context, state) => const MainShell(),
        ),
        GoRoute(
          path: '/shop',
          builder: (context, state) => const ShopPage(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrdersPage(),
        ),
        GoRoute(
          path: '/streak',
          builder: (context, state) => const StreakDetailPage(),
        ),
        GoRoute(
          path: '/challenge',
          builder: (context, state) => const ChallengeDetailPage(),
        ),
      ],
    );
  }
}
