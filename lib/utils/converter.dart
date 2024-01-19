import 'dart:convert';

dynamic fromJson(String jsonString) {
  return json.decode(jsonString);
}

String toJson(dynamic object) {
  var encoder = const JsonEncoder.withIndent("     ");
  return encoder.convert(object);
}
