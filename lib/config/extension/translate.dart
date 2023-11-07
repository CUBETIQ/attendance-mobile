// ignore_for_file: unnecessary_this

import 'package:get/get.dart';

extension FailTranslation on String {
  String get trString {
    try {
      return this.tr;
    } catch (error) {
      return this;
    }
  }
}
