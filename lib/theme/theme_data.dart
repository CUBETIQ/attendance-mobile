import 'package:flutter/material.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';

// Light theme
ThemeData lightTheme =
    ThemeData.from(colorScheme: flexSchemeLight, useMaterial3: true).copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColor.scaffoldBackground,
    elevation: 0,
  ),
  scaffoldBackgroundColor: MyColor.scaffoldBackground,
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: MyColor.scaffoldBackground,
    elevation: 0,
    labelTextStyle: MaterialStateProperty.resolveWith(
      (state) {
        if (state.contains(MaterialState.selected)) {
          return AppFonts.TitleXXSmall.copyWith(color: flexSchemeLight.primary);
        }
        return AppFonts.TitleXXSmall.copyWith(
          color: flexSchemeLight.outlineVariant,
        );
      },
    ),
  ),
);

const ColorScheme flexSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: MyColor.primary,
  onPrimary: MyColor.onPrimary,
  primaryContainer: MyColor.primaryContainer,
  onPrimaryContainer: Color(0xff121314),
  secondary: MyColor.secondaryIndigo,
  onSecondary: Color(0xffffffff),
  secondaryContainer: MyColor.secondaryRed,
  onSecondaryContainer: Color(0xff121314),
  tertiary: MyColor.success,
  onTertiary: MyColor.onSuccess,
  tertiaryContainer: MyColor.warning,
  onTertiaryContainer: MyColor.onWarning,
  error: MyColor.error,
  onError: MyColor.onError,
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff141212),
  background: MyColor.scaffoldBackground,
  onBackground: Color(0xff090909),
  surface: Color(0xfff9fafd),
  onSurface: MyColor.onBackground,
  surfaceVariant: Color(0xffe4e5eb),
  onSurfaceVariant: MyColor.onSurfaceVariant,
  outline: Color(0xFF636363),
  outlineVariant: Color(0xff7c7c7c),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff121215),
  onInverseSurface: Color(0xfff5f5f5),
  inversePrimary: Color.fromARGB(255, 218, 208, 255),
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
  outline: Color.fromARGB(255, 232, 232, 232),
  outlineVariant: Color.fromARGB(255, 207, 207, 207),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xfffbfbff),
  onInverseSurface: Color(0xff131314),
  inversePrimary: Color(0xff5e6277),
  surfaceTint: Color(0xffbac3ff),
);
