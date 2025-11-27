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
    _bootstrapTimer = Timer(const Duration(milliseconds: 800), () {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use FlutterLogo in tests/environments where the image asset
            // may not be available. This keeps the splash simple and robust
            // for CI.
            const FlutterLogo(size: 120),
            const SizedBox(height: 24),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
