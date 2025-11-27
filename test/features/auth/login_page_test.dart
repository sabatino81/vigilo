import 'package:flutter/material.dart';
import 'package:vigilo/features/auth/presentation/login_page.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginPage shows fields and button', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginPage(),
        ),
      ),
    );

    // allow localization delegates to load
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Sign in'), findsOneWidget);
  });
}
