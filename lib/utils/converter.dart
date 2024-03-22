import 'dart:convert';

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
