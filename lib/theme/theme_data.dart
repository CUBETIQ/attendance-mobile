import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/utils/theme_utils.dart';

// Light theme data
ThemeData lightThemeData() {
  return FlexThemeData.light(
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
    // scaffoldBackground: const Color(0xFFFFFFFF),
    blendLevel: 7,
    appBarElevation: 1,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    primary: const Color(0xff633FE8),
    onBackground: const Color(0xff24262B),
    keyColors: const FlexKeyColors(),
    // visualDensity: FlexColorScheme.comfortablePlatformDensity,
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
