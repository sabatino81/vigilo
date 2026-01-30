import 'package:vigilo/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthNotifier', () {
    late ProviderContainer container;

    setUp(() {
      // Override isAuthenticatedProvider to avoid Supabase dependency.
      container = ProviderContainer(
        overrides: [
          isAuthenticatedProvider.overrideWith((ref) => false),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('initial state is false', () {
      expect(container.read(authProvider), false);
    });

    test('signIn sets state to true', () async {
      final notifier = container.read(authProvider.notifier);
      await notifier.signIn();
      expect(container.read(authProvider), true);
    });
  });
}
