import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  LocalAuthService();

  final LocalAuthentication _auth =
  LocalAuthentication();

  Future<bool> canAuthenticate() async {
    return await _auth.canCheckBiometrics ||
        await _auth.isDeviceSupported();
  }

  Future<List<BiometricType>>
  availableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Unlock PocketIQ',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}