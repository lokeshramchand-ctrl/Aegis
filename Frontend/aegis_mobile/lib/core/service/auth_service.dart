// ignore_for_file: avoid_print

import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    try {
      // 1. Check if hardware supports local auth
      final bool isDeviceSupported = await _auth.isDeviceSupported();
      final bool canCheckBiometrics = await _auth.canCheckBiometrics;

      if (!isDeviceSupported && !canCheckBiometrics) return false;

      // 2. Call authenticate with 3.0.0 syntax (direct parameters)
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to open the app',
        // In 3.0.0, parameters are passed DIRECTLY, not inside 'options'
        biometricOnly: false,              // Set to false to allow PIN/Pattern fallback
        persistAcrossBackgrounding: true, // Replaces 'stickyAuth'
      );
    } on PlatformException catch (e) {
      print("Authentication Error: ${e.message}");
      return false;
    }
  }
}