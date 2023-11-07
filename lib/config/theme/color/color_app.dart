// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MyAppColor {
  static final MyAppColor _myAppColor = MyAppColor._internal();

  factory MyAppColor() {
    return _myAppColor;
  }

  MyAppColor._internal();
  static MyAppColor get instance => _myAppColor;

  Primary get primary => Primary._internal();

  Secondary get secondary => Secondary._internal();

  Status get status => Status._internal();

  Gray get gray => Gray._internal();

  Light get light => Light._internal();

  Alert get alert => Alert._internal();

  Gradient get gradient => Gradient._internal();
}

class Primary {
  static final Primary _primary = Primary._internal();

  factory Primary() {
    return _primary;
  }

  Primary._internal();

  final Color Main = const Color(0xff34B67F);
  final Color P1 = const Color(0xff1D8D5E);
  final Color P2 = const Color(0xff23A06C);
  final Color P3 = const Color(0xff46C58F);
  final Color P4 = const Color(0xff84E0B9);
  final Color P5 = const Color(0xffD3F9E9);
}

class Secondary {
  static final Secondary _secondary = Secondary._internal();

  factory Secondary() {
    return _secondary;
  }

  Secondary._internal();

  final Color Main = const Color(0xff1A1C1E);
  final Color S1 = const Color(0xff151719);
  final Color S2 = const Color(0xff3B3E41);
  final Color S3 = const Color(0xff6D7073);
  final Color S4 = const Color(0xffA7AAAC);
  final Color S5 = const Color(0xffDCDFE1);
}

class Status {
  static final Status _status = Status._internal();

  factory Status() {
    return _status;
  }

  Status._internal();

  final Color Disabled = const Color(0xffD8D8D8);
  final Color DisabledButton = const Color(0xff879AC1);
}

class Alert {
  static final Alert _alert = Alert._internal();

  factory Alert() {
    return _alert;
  }

  Alert._internal();

  final Color Success = const Color(0xff34B67F);
  final Color Info = const Color(0xff3173FA);
  final Color Warning = const Color(0xffFFE16A);
  final Color Error = const Color(0xffFF3333);
}

class Gray {
  static final Gray _gray = Gray._internal();

  factory Gray() {
    return _gray;
  }

  Gray._internal();

  final Color G1 = const Color(0xff1A1C1E);
  final Color G2 = const Color(0xff424242);
  final Color G3 = const Color(0xff616161);
  final Color G4 = const Color(0xff757575);
  final Color G5 = const Color(0xff9E9E9E);
}

class Light {
  static final Light _light = Light._internal();

  factory Light() {
    return _light;
  }

  Light._internal();

  final Color L1 = const Color(0xffBDBDBD);
  final Color L2 = const Color(0xffE0E0E0);
  final Color L3 = const Color(0xffEEEEEE);
  final Color L4 = const Color(0xffFAFAFC);
  final Color L5 = const Color(0xffFFFFFF);
}

class Gradient {
  static final Gradient _gradient = Gradient._internal();

  factory Gradient() {
    return _gradient;
  }

  Gradient._internal();
  final LinearGradient Blue = const LinearGradient(
    colors: [Color(0xff60EFFF), Color(0xff0061FF)],
  );
  final LinearGradient Green = const LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
    colors: [Color(0xff0DEA4B), Color(0xff47EDFF)],
  );
  final LinearGradient Yellow = const LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
    colors: [Color(0xffFFE580), Color.fromARGB(255, 252, 205, 20)],
  );
  final LinearGradient Red = const LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
    colors: [Color(0xffFF3333), Color(0xffFF8A9B)],
  );
  final LinearGradient Pink = const LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
    colors: [Color(0xffF1ABFD), Color.fromARGB(255, 250, 83, 122)],
  );
  final LinearGradient Black = const LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
    colors: [Color(0xff1A1C1E), Color(0xff1A1C1E)],
  );
  final LinearGradient White = const LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
    colors: [Colors.white, Colors.white],
  );
}
