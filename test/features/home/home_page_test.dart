import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/features/home/presentation/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomePage renders as scrollable list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: HomePage()),
      ),
    );

    // HomePage is a ListView — verify it renders without errors.
    expect(find.byType(ListView), findsOneWidget);
  });
}
