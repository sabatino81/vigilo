import 'package:flutter_app_template/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AuthNotifier toggles login state', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(authProvider.notifier);

    expect(container.read(authProvider), false);
    notifier.signIn();
    expect(container.read(authProvider), true);
    notifier.signOut();
    expect(container.read(authProvider), false);
  });
}
