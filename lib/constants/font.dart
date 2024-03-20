// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFonts {
  static final AppFonts _instance = AppFonts._internal();

  factory AppFonts() => _instance;

  AppFonts._internal();

  static const String fontFamily = 'Inter';

  double calculateFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 450) {
      return baseSize * 1.5;
    } else if (screenWidth <= 375) {
      return baseSize * 0.85;
    } else {
      return baseSize;
    }
  }

  TextStyle generateTextStyle({
    FontWeight fontWeight = FontWeight.bold,
    double fontSize = 16,
  }) {
    double adjustedFontSize = calculateFontSize(Get.context!, fontSize);
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: adjustedFontSize,
      letterSpacing: 0.2,
    );
  }

  TextStyle get headingH1 => generateTextStyle(fontSize: 48);
  TextStyle get headingH2 => generateTextStyle(fontSize: 40);
  TextStyle get headingH3 => generateTextStyle(fontSize: 32);
  TextStyle get headingH4 => generateTextStyle(fontSize: 24);
  TextStyle get headingH5 => generateTextStyle(fontSize: 20);

  TextStyle get bodyXXXlarge => generateTextStyle(fontSize: 26);
  TextStyle get bodyXXlarge => generateTextStyle(fontSize: 24);
  TextStyle get bodyXlarge => generateTextStyle(fontSize: 18);
  TextStyle get bodyLarge => generateTextStyle(fontSize: 16);
  TextStyle get bodyMedium => generateTextStyle(fontSize: 14);
  TextStyle get bodySmall => generateTextStyle(fontSize: 12);
  TextStyle get bodyXSmall => generateTextStyle(fontSize: 10);
  TextStyle get bodyXXSmall => generateTextStyle(fontSize: 8);

  TextStyle get bodyXXXlargeSemi =>
      generateTextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  TextStyle get bodyXXlargeSemi =>
      generateTextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  TextStyle get bodyXlargeSemi =>
      generateTextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  TextStyle get bodyLargeSemi =>
      generateTextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  TextStyle get bodyMediumSemi =>
      generateTextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  TextStyle get bodySmallSemi =>
      generateTextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  TextStyle get bodyXSmallSemi =>
      generateTextStyle(fontSize: 10, fontWeight: FontWeight.w600);
  TextStyle get bodyXXSmallSemi =>
      generateTextStyle(fontSize: 8, fontWeight: FontWeight.w600);

  TextStyle get bodyXXXlargeMedium =>
      generateTextStyle(fontSize: 24, fontWeight: FontWeight.w500);
  TextStyle get bodyXXlargeMedium =>
      generateTextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  TextStyle get bodyXlargeMedium =>
      generateTextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle get bodyLargeMedium =>
      generateTextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  TextStyle get bodyMediumMedium =>
      generateTextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get bodySmallMedium =>
      generateTextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  TextStyle get bodyXSmallMedium =>
      generateTextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  TextStyle get bodyXXSmallMedium =>
      generateTextStyle(fontSize: 8, fontWeight: FontWeight.w500);

  TextStyle get bodyXXXlargeRegular =>
      generateTextStyle(fontSize: 24, fontWeight: FontWeight.w400);
  TextStyle get bodyXXlargeRegular =>
      generateTextStyle(fontSize: 22, fontWeight: FontWeight.w400);
  TextStyle get bodyXlargeRegular =>
      generateTextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  TextStyle get bodyLargeRegular =>
      generateTextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  TextStyle get bodyMediumRegular =>
      generateTextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  TextStyle get bodySmallRegular =>
      generateTextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get bodyXSmallRegular =>
      generateTextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get bodyXXSmallRegular =>
      generateTextStyle(fontSize: 8, fontWeight: FontWeight.w400);

  // New Style From Figma

  TextStyle get TitleSmall =>
      generateTextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  TextStyle get LabelMedium =>
      generateTextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  TextStyle get BodyXSmall =>
      generateTextStyle(fontSize: 12, fontWeight: FontWeight.w400);
}
