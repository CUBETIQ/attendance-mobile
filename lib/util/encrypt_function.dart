import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
// import 'package:crypto/crypto.dart';

// class MyEncryption {
//   String generateUUID() {
//     final random = Random.secure();
//     final values = List<int>.generate(16, (i) => random.nextInt(256));

//     // Set version to 4
//     values[6] = (values[6] & 0x0F) | 0x40;
//     // Set variant to RFC4122
//     values[8] = (values[8] & 0x3F) | 0x80;

//     final bytes = Uint8List.fromList(values);

//     final digest = sha1.convert(bytes);
//     final buffer = StringBuffer();
//     final data = digest.bytes;

//     for (var i = 0; i < data.length; i++) {
//       if (i == 4 || i == 6 || i == 8 || i == 10) {
//         buffer.write('-');
//       }
//       buffer.write(data[i].toRadixString(16).padLeft(2, '0'));
//     }

//     return buffer.toString();
//   }

//   String createHash(String secretKey, String data) {
//     var hmac = Hmac(sha256, utf8.encode(secretKey));
//     return hmac.convert(utf8.encode(data)).toString();
//   }
// }
