import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/utils/theme_utils.dart';

// Light theme data
ThemeData lightThemeData() {
  return FlexThemeData.light(
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
    primary: AppConfig.theme == null ? const Color(0xFF633FE8) : null,
    keyColors: const FlexKeyColors(),
    // visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
  );
}

// Dark theme data
ThemeData darkThemeData() {
  return FlexThemeData.dark(
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
    primary: AppConfig.theme == null ? const Color(0xFF633FE8) : null,
    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
  );
}
