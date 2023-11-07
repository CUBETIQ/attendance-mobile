import 'package:cubetiq_attendance_app/config/theme/font/default_font.dart';
import 'package:flutter/material.dart';

ThemeData buildSchemeLight() {
  final ThemeData base = ThemeData.light(useMaterial3: false);
  return base.copyWith(
      //Turn off and on default splash and highlight color
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: TextTheme(
        headlineLarge: HeadingH1,
        headlineSmall: HeadingH5,
        //Large
        displayLarge: BodyLarge,
        bodyLarge: BodyLargeRegular,
        titleLarge: BodyXlarge,
        headlineMedium: BodyLargeMedium,
        labelLarge: BodyLargeSemi,
        displaySmall: BodyXlargeRegular,
        //Medium
        displayMedium: BodyMediumMedium,
        labelMedium: BodyMediumSemi,
        //Small
        bodyMedium: BodyXSmallMedium,
        titleMedium: BodySmallMedium,
        labelSmall: BodyXSmallSemi,
        bodySmall: BodyXSmallRegular,
        titleSmall: BodySmallRegular,
      ),
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.light,
        primary: const Color(0xff34B67F),
        onPrimary: const Color(0xffD3F9E9),
        secondary: const Color(0xff1A1C1E),
        onSecondary: const Color(0xffDCDFE1),
        error: const Color(0xffFF3333),
        onError: const Color(0xffFAFAFC),
        background: const Color(0xffFAFAFC),
        onBackground: const Color(0xff1A1C1E),
        surface: const Color(0xff9E9E9E),
        onSurface: const Color(0xff1A1C1E),
        outline: const Color(0xffA7AAAC),
        primaryContainer: const Color(0xffD3F9E9),
        secondaryContainer: const Color(0xffDCDFE1),
        onPrimaryContainer: const Color(0xff1D8D5E),
        onSecondaryContainer: const Color(0xff151719),
      ));
}

ThemeData buildSchemeDarker() {
  final ThemeData base = ThemeData.dark(
    useMaterial3: false,
  );
  return base.copyWith(
      //Turn off and on default splash and highlight color
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      textTheme: TextTheme(
          bodySmall: BodyXSmallRegular,
          titleSmall: BodySmallRegular,
          displaySmall: BodyXlargeRegular,
          headlineSmall: HeadingH5,
          bodyMedium: BodyXSmallMedium,
          titleMedium: BodySmallMedium,
          displayMedium: BodyMediumMedium,
          headlineMedium: BodyLargeMedium,
          titleLarge: BodyXlarge,
          bodyLarge: BodyLargeRegular,
          labelLarge: BodyLargeSemi,
          displayLarge: BodyLarge,
          headlineLarge: HeadingH1,
          labelMedium: BodyMediumSemi,
          labelSmall: BodyXSmallSemi),
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.dark,
        primary: const Color(0xff34B67F),
        onPrimary: const Color(0xffD3F9E9),
        secondary: const Color(0xff1A1C1E),
        onSecondary: const Color(0xffDCDFE1),
        error: const Color(0xffFF3333),
        onError: const Color(0xffFF3333),
        background: const Color(0xff1A1C1E),
        onBackground: const Color(0xffFFFFFF),
        surface: const Color(0xff1A1C1E),
        onSurface: const Color(0xff9E9E9E),
        outline: const Color(0xffDCDFE1),
        primaryContainer: const Color(0xffD3F9E9),
        secondaryContainer: const Color(0xffDCDFE1),
        onPrimaryContainer: const Color(0xff1D8D5E),
        onSecondaryContainer: const Color(0xff151719),
      ));
}

final ThemeData light = buildSchemeLight();
final ThemeData dark = buildSchemeDarker();
