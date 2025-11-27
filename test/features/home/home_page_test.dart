import 'package:flutter/material.dart';
import 'package:vigilo/features/home/presentation/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomePage shows welcome and logout button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });
}
