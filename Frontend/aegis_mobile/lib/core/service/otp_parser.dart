// lib/core/otp_parser.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OTPManager {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveOTP(String url) async {
    final uri = Uri.parse(url);
    if (uri.scheme != 'otpauth') return;

    // url looks like: otpauth://totp/GitHub:user?secret=JBSWY...&issuer=GitHub
    final String label = uri.pathSegments.last; // e.g., GitHub:user
    final String? secret = uri.queryParameters['secret'];
    final String issuer = uri.queryParameters['issuer'] ?? 'Unknown';

    if (secret != null) {
      // Save as JSON string in secure storage
      await _storage.write(
        key: 'otp_$label', 
        value: '{"secret": "$secret", "issuer": "$issuer", "label": "$label"}'
      );
    }
  }
}