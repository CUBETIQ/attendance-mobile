import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/utils/theme_utils.dart';

// Light theme data
ThemeData lightThemeData() {
  return FlexThemeData.light(
    // user for override
    colors: const FlexSchemeColor(
      primary: Color(0xff065808),
      primaryContainer: Color(0xff9ee29f),
      secondary: Color(0xff365b37),
      secondaryContainer: Color(0xffaebdaf),
      tertiary: Color(0xff2c7e2e),
      tertiaryContainer: Color(0xffb8e6b9),
      appBarColor: Color(0xffb8e6b9),
      error: Color(0xffb00020),
    ),
    // scheme: ThemeUtil.getFlexScheme(AppConfig.theme),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    scaffoldBackground: const Color(0xFFFFFFFF),
    blendLevel: 7,
    appBarElevation: 1,

    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
  );
}

// Dark theme data
ThemeData darkThemeData() {
  return FlexThemeData.dark(
    // user for override
    // colors: const FlexSchemeColor(
    //   primary: Color(0xff065808),
    //   primaryContainer: Color(0xff9ee29f),
    //   secondary: Color(0xff365b37),
    //   secondaryContainer: Color(0xffaebdaf),
    //   tertiary: Color(0xff2c7e2e),
    //   tertiaryContainer: Color(0xffb8e6b9),
    //   appBarColor: Color(0xffb8e6b9),
    //   error: Color(0xffb00020),
    // ),
    scheme: ThemeUtil.getFlexScheme(AppConfig.theme),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    // scaffoldBackground: const Color(0xff121212),
    appBarElevation: 1,
    blendLevel: 13,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    keyColors: const FlexKeyColors(),
    primary: const Color(0xff633FE8),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
  );
}

// Color Scheme

// Light theme
ThemeData lightTheme =
    ThemeData.from(colorScheme: flexSchemeLight, useMaterial3: true);
const ColorScheme flexSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: MyColor.primary,
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffdee0ff),
  onPrimaryContainer: Color(0xff121314),
  secondary: Color(0xff3c64ae),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffd8e2ff),
  onSecondaryContainer: Color(0xff121314),
  tertiary: Color(0xff537577),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffa9d4d6),
  onTertiaryContainer: Color(0xff0e1212),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff141212),
  background: Color(0xfff9fafd),
  onBackground: Color(0xff090909),
  surface: Color(0xfff9fafd),
  onSurface: Color(0xff090909),
  surfaceVariant: Color(0xffe4e5eb),
  onSurfaceVariant: Color(0xff111112),
  outline: Color(0xff7c7c7c),
  outlineVariant: Color(0xffc8c8c8),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff121215),
  onInverseSurface: Color(0xfff5f5f5),
  inversePrimary: Color(0xffdce3ff),
  surfaceTint: Color(0xff4355b9),
);

// Dark theme
ThemeData darkTheme =
    ThemeData.from(colorScheme: flexSchemeDark, useMaterial3: true);
const ColorScheme flexSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffbac3ff),
  onPrimary: Color(0xff121314),
  primaryContainer: Color(0xff293ca0),
  onPrimaryContainer: Color(0xffe6e9f8),
  secondary: Color(0xffaec6ff),
  onSecondary: Color(0xff111314),
  secondaryContainer: Color(0xff14448d),
  onSecondaryContainer: Color(0xffe2eaf5),
  tertiary: Color(0xffa9cdcf),
  onTertiary: Color(0xff111414),
  tertiaryContainer: Color(0xff2a4c4e),
  onTertiaryContainer: Color(0xffe6ebec),
  error: Color(0xffffb4ab),
  onError: Color(0xff141211),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xfff6dfe1),
  background: Color(0xff191a1d),
  onBackground: Color(0xffeceded),
  surface: Color(0xff191a1d),
  onSurface: Color(0xffeceded),
  surfaceVariant: Color(0xff3f4046),
  onSurfaceVariant: Color(0xffe0e1e1),
  outline: Color(0xff767d7d),
  outlineVariant: Color(0xff2c2e2e),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xfffbfbff),
  onInverseSurface: Color(0xff131314),
  inversePrimary: Color(0xff5e6277),
  surfaceTint: Color(0xffbac3ff),
);
