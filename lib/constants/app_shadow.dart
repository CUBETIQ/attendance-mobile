import 'package:flutter/material.dart';

class AppShadow {
  static BoxShadow shadowWithColor(Color color) => BoxShadow(
        color: color.withOpacity(0.19),
        blurRadius: 6,
        spreadRadius: 1,
        offset: const Offset(0, 4),
      );

  static BoxShadow shadowWithoutColor = BoxShadow(
    color: const Color(0xFF000000).withOpacity(0.08),
    blurRadius: 6,
    spreadRadius: 0,
    offset: const Offset(0, 4),
  );
}
