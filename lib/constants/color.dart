import 'package:flutter/material.dart';

class MyColor {
  static final MyColor _instance = MyColor._internal();

  factory MyColor() {
    return _instance;
  }

  MyColor._internal();

  static const int success = 0xFF198754;
  static const int darkSuccess = 0xFF1D6E20;
  static const int error = 0xFFBA1A1A;
  static const int warning = 0xFFE0A800;

  static const Color pendingColor = Color(0XFFBF9705);
  static const Color successColor = Color(0xFF08B80E);
  static const Color errorColor = Color(0xFFD72E08);
}
