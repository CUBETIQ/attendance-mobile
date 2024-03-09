import 'package:flutter/widgets.dart';

class Validator {
  Validator._();

  static bool isValNull(String? val) {
    if (val == null || val.isEmpty == true) {
      return true;
    }
    return false;
  }

  static bool validateFormKeys(List<GlobalKey<FormState>> keys) {
    var valid = true;
    for (var key in keys) {
      if (key.currentState?.validate() == false) {
        valid = false;
      } else {
        key.currentState?.save();
      }
    }

    return valid;
  }

  static bool isAnyNullOrEmpty(List<String?> vals) {
    return vals.any((element) => isValNull(element));
  }

  static bool isAllNullOrEmpty(List<String?> vals) {
    return vals.every((element) => isValNull(element));
  }

  static bool isAnyNotNullOrEmpty(List<String?> vals) {
    return vals.any((element) => !isValNull(element));
  }



}
