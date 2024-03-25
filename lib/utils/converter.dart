import 'dart:convert';

import 'package:crypto/crypto.dart';

dynamic fromJson(String jsonString) {
  return json.decode(jsonString);
}

String toJson(dynamic object) {
  var encoder = const JsonEncoder.withIndent("     ");
  return encoder.convert(object);
}

String? toBase64(String? text) {
  if (text == null) {
    return null;
  }
  return base64.encode(utf8.encode(text));
}

String? fromBase64(String? text) {
  if (text == null) {
    return null;
  }
  return utf8.decode(base64.decode(text));
}

int? generateUniqueIntId(String? mongoId) {
  if (mongoId == null) {
    return null;
  }
  // Convert the MongoDB ID string to bytes
  List<int> bytes = utf8.encode(mongoId);

  // Calculate a hash of the bytes using SHA-256
  Digest digest = sha256.convert(bytes);

  // Convert the hash bytes to an integer
  int uniqueId = digest.bytes.reduce((value, element) => value ^ element);

  // Make sure the ID is positive
  uniqueId = uniqueId.abs();

  return uniqueId;
}
