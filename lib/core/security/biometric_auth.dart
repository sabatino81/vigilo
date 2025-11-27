import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Returns true if device supports biometrics and user successfully
  /// authenticates.
  Future<bool> authenticate({String reason = 'Please authenticate'}) async {
    final canCheck = await _auth.canCheckBiometrics;
    if (!canCheck) return false;

    try {
      // local_auth v3 exposes `biometricOnly` directly on `authenticate`.
      return await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
      );
    } on Exception {
      return false;
    }
  }
}
