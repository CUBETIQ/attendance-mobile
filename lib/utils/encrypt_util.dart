import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptUtil {
  static String createHash(String secretKey, String data) {
    var hmac = Hmac(sha256, utf8.encode(secretKey));
    return hmac.convert(utf8.encode(data)).toString();
  }
}
