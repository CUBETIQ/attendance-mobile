

import 'package:get/get.dart';

extension StringExtension on String {
  //Convert string to int
  int toInt() {
    return int.tryParse(this) ?? 0;
  }

  //Convert string to double
  double toDouble() {
    return double.tryParse(this) ?? 0.0; // Returns 0.0 if conversion fails
  }

  // Remove whitespace from the beginning and end of the string
  String trim() {
    return this.trim();
  }

  //Capitalize first letter
  String capitalizeFirstLetter() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  // Capitalize the first letter of each word in the string
  String capitalizeEachWord() {
    return split(' ').map((word) => word.capitalizeFirstLetter()).join(' ');
  }

  //Validate email
  bool isValidEmail() {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        caseSensitive: false);
    return emailRegex.hasMatch(this);
  }

  //Validate url
  bool isValidUrl() {
    final urlRegex =
        RegExp(r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$', caseSensitive: false);
    return urlRegex.hasMatch(this);
  }

  //Translate string
  String get trString {
    try {
      return tr;
    } catch (error) {
      return this;
    }
  }
}
