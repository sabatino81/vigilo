import 'package:flutter_app_template/features/auth/data/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  late MockGoTrueClient mockClient;
  late AuthService authService;

  setUp(() {
    mockClient = MockGoTrueClient();
    authService = AuthService(authClient: mockClient);
  });

  test('signIn calls underlying client and propagates exception', () async {
    when(
      () => mockClient.signInWithPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception('auth failed'));

    expect(
      () => authService.signIn('a@b.com', 'pass'),
      throwsA(isA<Exception>()),
    );

    verify(
      () => mockClient.signInWithPassword(email: 'a@b.com', password: 'pass'),
    ).called(1);
  });

  test('signUp calls underlying client and propagates exception', () async {
    when(
      () => mockClient.signUp(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception('signup failed'));

    expect(
      () => authService.signUp('x@y.com', 'pass'),
      throwsA(isA<Exception>()),
    );

    verify(
      () => mockClient.signUp(email: 'x@y.com', password: 'pass'),
    ).called(1);
  });

  test('signOut calls underlying client and propagates exception', () async {
    when(() => mockClient.signOut()).thenThrow(Exception('signout failed'));

    expect(() => authService.signOut(), throwsA(isA<Exception>()));

    verify(() => mockClient.signOut()).called(1);
  });
}
