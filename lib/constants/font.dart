// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFonts {
  static final AppFonts _instance = AppFonts._internal();

  factory AppFonts() => _instance;

  AppFonts._internal();

  static const String fontFamily = 'PlusJakartaSans'; // 'Inter';

  static double _calculateFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 450) {
      return baseSize * 1.5;
    } else if (screenWidth <= 375) {
      return baseSize * 0.85;
    } else {
      return baseSize;
    }
  }

  static TextStyle _generateTextStyle({
    FontWeight fontWeight = FontWeight.bold,
    double fontSize = 16,
  }) {
    double adjustedFontSize = _calculateFontSize(Get.context!, fontSize);
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: adjustedFontSize,
      letterSpacing: 0,
    );
  }

  TextStyle get headingH1 => _generateTextStyle(fontSize: 48);
  TextStyle get headingH2 => _generateTextStyle(fontSize: 40);
  TextStyle get headingH3 => _generateTextStyle(fontSize: 32);
  TextStyle get headingH4 => _generateTextStyle(fontSize: 24);
  TextStyle get headingH5 => _generateTextStyle(fontSize: 20);

  TextStyle get bodyXXXlarge => _generateTextStyle(fontSize: 26);
  TextStyle get bodyXXlarge => _generateTextStyle(fontSize: 24);
  TextStyle get bodyXlarge => _generateTextStyle(fontSize: 18);
  TextStyle get bodyLarge => _generateTextStyle(fontSize: 16);
  TextStyle get bodyMedium => _generateTextStyle(fontSize: 14);
  TextStyle get bodySmall => _generateTextStyle(fontSize: 12);
  TextStyle get bodyXSmall => _generateTextStyle(fontSize: 10);
  TextStyle get bodyXXSmall => _generateTextStyle(fontSize: 8);

  TextStyle get bodyXXXlargeSemi =>
      _generateTextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  TextStyle get bodyXXlargeSemi =>
      _generateTextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  TextStyle get bodyXlargeSemi =>
      _generateTextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  TextStyle get bodyLargeSemi =>
      _generateTextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  TextStyle get bodyMediumSemi =>
      _generateTextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  TextStyle get bodySmallSemi =>
      _generateTextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  TextStyle get bodyXSmallSemi =>
      _generateTextStyle(fontSize: 10, fontWeight: FontWeight.w600);
  TextStyle get bodyXXSmallSemi =>
      _generateTextStyle(fontSize: 8, fontWeight: FontWeight.w600);

  TextStyle get bodyXXXlargeMedium =>
      _generateTextStyle(fontSize: 24, fontWeight: FontWeight.w500);
  TextStyle get bodyXXlargeMedium =>
      _generateTextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  TextStyle get bodyXlargeMedium =>
      _generateTextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle get bodyLargeMedium =>
      _generateTextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  TextStyle get bodyMediumMedium =>
      _generateTextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get bodySmallMedium =>
      _generateTextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  TextStyle get bodyXSmallMedium =>
      _generateTextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  TextStyle get bodyXXSmallMedium =>
      _generateTextStyle(fontSize: 8, fontWeight: FontWeight.w500);

  TextStyle get bodyXXXlargeRegular =>
      _generateTextStyle(fontSize: 24, fontWeight: FontWeight.w400);
  TextStyle get bodyXXlargeRegular =>
      _generateTextStyle(fontSize: 22, fontWeight: FontWeight.w400);
  TextStyle get bodyXlargeRegular =>
      _generateTextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  TextStyle get bodyLargeRegular =>
      _generateTextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  TextStyle get bodyMediumRegular =>
      _generateTextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  TextStyle get bodySmallRegular =>
      _generateTextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get bodyXSmallRegular =>
      _generateTextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get bodyXXSmallRegular =>
      _generateTextStyle(fontSize: 8, fontWeight: FontWeight.w400);

  // <======================== Style From Figma ========================>

  // Display =>

  /// Font Size: 36
  static TextStyle get DisplayLarge => _generateTextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w500,
      );

  /// Font Size: 32
  static TextStyle get DisplayMedium => _generateTextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
      );

  /// Font Size: 28
  static TextStyle get DisplaySmall => _generateTextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
      );

  // Headline =>

  /// Font Size: 26
  static TextStyle get HeadlineLarge => _generateTextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
      );

  /// Font Size: 24
  static TextStyle get HeadlineMedium => _generateTextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );

  /// Font Size: 20
  static TextStyle get HeadlineSmall => _generateTextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  // Title =>

  /// Font Size: 18
  static TextStyle get TitleLarge => _generateTextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  /// Font Size: 16
  static TextStyle get TitleMedium => _generateTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  /// Font Size: 14
  static TextStyle get TitleSmall => _generateTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  /// Font Size: 12
  static TextStyle get TitleXSmall => _generateTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  /// Font Size: 10
  static TextStyle get TitleXXSmall => _generateTextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );

  // Label =>

  /// Font Size: 16
  static TextStyle get LabelLarge => _generateTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  /// Font Size: 14
  static TextStyle get LabelMedium => _generateTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  /// Font Size: 12
  static TextStyle get LabelSmall => _generateTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  /// Font Size: 10
  static TextStyle get LabelXSmall => _generateTextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
      );

  // Body =>

  /// Font Size: 18
  static TextStyle get BodyLarge => _generateTextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );

  /// Font Size: 16
  static TextStyle get BodyMedium => _generateTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  /// Font Size: 14
  static TextStyle get BodySmall => _generateTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  /// Font Size: 12
  static TextStyle get BodyXSmall => _generateTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  /// Font Size: 10
  static TextStyle get BodyXXSmall => _generateTextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      );
}
