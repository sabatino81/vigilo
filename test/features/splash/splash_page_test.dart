import 'package:flutter/material.dart';
import 'package:vigilo/features/splash/presentation/splash_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplashPage shows progress indicator', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SplashPage()));

    // CircularProgressIndicator is rendered immediately.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Image.asset is present (even if the asset fails to load in tests).
    expect(find.byType(Image), findsOneWidget);
  });
}
