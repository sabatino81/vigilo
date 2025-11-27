import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/splash/presentation/splash_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplashPage shows logo and progress', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SplashPage()));

    // expects a CircularProgressIndicator and a FlutterLogo
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(FlutterLogo), findsOneWidget);
  });
}
