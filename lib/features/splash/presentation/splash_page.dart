import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// We intentionally start an async bootstrap during initState and don't
/// await the returned future (we rely on mounted checks). This is a known
/// pattern for splash screens where the UI needs to show immediately.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _bootstrapTimer;

  @override
  void initState() {
    super.initState();
    // Use a cancellable Timer so tests can dispose the widget without
    // leaving pending timers active.
    _bootstrapTimer = Timer(const Duration(milliseconds: 2500), () {
      final session = Supabase.instance.client.auth.currentSession;
      if (!mounted) return;
      if (session == null) {
        context.go('/login');
      } else {
        context.go('/home');
      }
    });
  }

  @override
  void dispose() {
    _bootstrapTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF1A1A1A,
      ), // Dark background matching splash
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Vigilo splash screen with fade-in animation
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 600),
              child: Image.asset(
                'assets/logo/splash.jpg',
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to FlutterLogo if image not found (CI/tests)
                  return const FlutterLogo(size: 120);
                },
              ),
            ),
            const SizedBox(height: 48),
            CircularProgressIndicator(
              color: const Color(0xFFFFB800), // Safety yellow
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
