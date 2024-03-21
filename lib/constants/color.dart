import 'package:flutter/material.dart';
import 'package:timesync/feature/setting/change_theme/model/theme_model.dart';

class MyColor {
  static final MyColor _instance = MyColor._internal();

  factory MyColor() {
    return _instance;
  }

  MyColor._internal();

  static const int success = 0xFF198754;
  static const int darkSuccess = 0xFF1D6E20;
  static const int warning = 0xFFE0A800;

  static const Color pendingColor = Color(0XFFBF9705);
  static const Color successColor = Color(0xFF08B80E);
  static const Color errorColor = Color(0xFFD72E08);

  // App Color Scheme
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xff24262B);
  static const Color primary = Color(0xff633FE8);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color error = Color(0xffF75656);
  static const Color onError = Color(0xFFFFFFFF);

  // Theme Color Name
  static String get purple => "purpleM3";
  static String get red => "redM3";
  static String get pink => "pinkM3";
  static String get orange => "orangeM3";
  static String get green => "greenM3";
  static String get materialHc => "materialHc";
  static String get sakura => "sakura";
  static String get gold => "gold";
  static String get indigo => "indigoM3";
  static String get lime => "limeM3";
  static String get cyan => "cyanM3";
  static String get blue => "blue";
  static String get hippieBlue => "hippieBlue";
  static String get aquaBlue => "aquaBlue";
  static String get mandyRed => "mandyRed";
  static String get purpleBrown => "purpleBrown";
  static String get deepOrange => "deepOrangeM3";
  static String get brandBlue => "brandBlue";
  static String get money => "money";
  static String get greyLaw => "greyLaw";
  static String get wasabi => "wasabi";
  static String get mango => "mango";
  static String get amber => "amber";

  // Color used for change theme
  static final themeLists = <ThemeModel>[
    ThemeModel(
      color: purple,
      primary: const Color(0xFF9A25AE),
      primaryContainer: const Color(0xFFFFD6FE),
      secondary: const Color(0xFF8728CF),
      tertiary: const Color(0xFF934932),
    ),
    ThemeModel(
      color: red,
      primary: const Color(0xFFBB1614),
      primaryContainer: const Color(0xFFFFDAD5),
      secondary: const Color(0xFF8728CF),
      tertiary: const Color(0xFF934932),
    ),
    ThemeModel(
      color: pink,
      primary: const Color(0xFFBC004B),
      primaryContainer: const Color(0xFFFFD9DE),
      secondary: const Color(0xFF9B4050),
      tertiary: const Color(0xFF874978),
    ),
    ThemeModel(
      color: orange,
      primary: const Color(0xFF8B5000),
      primaryContainer: const Color(0xFFFFDCBE),
      secondary: const Color(0xFFB6602F),
      tertiary: const Color(0xFF466827),
    ),
    ThemeModel(
      color: green,
      primary: const Color(0xFF006E1C),
      primaryContainer: const Color(0xFFB6F2AF),
      secondary: const Color(0xFF36855E),
      tertiary: const Color(0xFF00658C),
    ),
    ThemeModel(
      color: materialHc,
      primary: const Color(0xFF0000BA),
      primaryContainer: const Color(0xFFB6B6FF),
      secondary: const Color(0xFF018786),
      tertiary: const Color(0xFF66FFF9),
    ),
    ThemeModel(
      color: sakura,
      primary: const Color(0xFFCE5B78),
      primaryContainer: const Color(0xFFE8B5CE),
      secondary: const Color(0xFFFBAE9D),
      tertiary: const Color(0xFFF39682),
    ),
    ThemeModel(
      color: gold,
      primary: const Color(0xFFB86914),
      primaryContainer: const Color(0xFFF2C18C),
      secondary: const Color(0xFFB36832),
      tertiary: const Color(0xFFEF6C00),
    ),
    ThemeModel(
      color: indigo,
      primary: const Color(0xFF4355B9),
      primaryContainer: const Color(0xFFDEE0FF),
      secondary: const Color(0xFF3C64AE),
      tertiary: const Color(0xFF537577),
    ),
    ThemeModel(
      color: lime,
      primary: const Color(0xFF556500),
      primaryContainer: const Color(0xFFDAEB8F),
      secondary: const Color(0xFF8C7519),
      tertiary: const Color(0xFF00687B),
    ),
    ThemeModel(
      color: cyan,
      primary: const Color(0xFF006876),
      primaryContainer: const Color(0xFFA1EFFF),
      secondary: const Color(0xFF476365),
      tertiary: const Color(0xFF585C82),
    ),
    ThemeModel(
      color: blue,
      primary: const Color(0xFF1565C0),
      primaryContainer: const Color(0xFF90CAF9),
      secondary: const Color(0xFF0277BD),
      tertiary: const Color(0xFF039BE5),
    ),
    ThemeModel(
      color: hippieBlue,
      primary: const Color(0xFF4C9BBA),
      primaryContainer: const Color(0xFF9CEBEB),
      secondary: const Color(0xFFBF4A50),
      tertiary: const Color(0xFFFF4F58),
    ),
    ThemeModel(
      color: aquaBlue,
      primary: const Color(0xFF35A0CB),
      primaryContainer: const Color(0xFF71D3ED),
      secondary: const Color(0xFF89D1C8),
      tertiary: const Color(0xFF61D4D4),
    ),
    ThemeModel(
      color: mandyRed,
      primary: const Color(0xFFCD5758),
      primaryContainer: const Color(0xFFE49797),
      secondary: const Color(0xFF69B9CD),
      tertiary: const Color(0xFF57C8D3),
    ),
    ThemeModel(
      color: purpleBrown,
      primary: const Color(0xFF450A0F),
      primaryContainer: const Color(0xFFB9A6A8),
      secondary: const Color(0xFF4A0635),
      tertiary: const Color(0xFF60234F),
    ),
    ThemeModel(
      color: deepOrange,
      primary: const Color(0xFFBF360C),
      primaryContainer: const Color(0xFFFFDBD1),
      secondary: const Color(0xFFBE593B),
      tertiary: const Color(0xFF466827),
    ),
    ThemeModel(
      color: brandBlue,
      primary: const Color(0xFF3B5998),
      primaryContainer: const Color(0xFFA8CAE6),
      secondary: const Color(0xFF55ACEE),
      tertiary: const Color(0xFF4285F4),
    ),
    ThemeModel(
      color: money,
      primary: const Color(0xFF264E36),
      primaryContainer: const Color(0xFF94BDA5),
      secondary: const Color(0xFF555729),
      tertiary: const Color(0xFF797B3A),
    ),
    ThemeModel(
      color: greyLaw,
      primary: const Color(0xFF37474F),
      primaryContainer: const Color(0xFFB0BEC5),
      secondary: const Color(0xFF2C314F),
      tertiary: const Color(0xFF521D82),
    ),
    ThemeModel(
      color: wasabi,
      primary: const Color(0xFF738625),
      primaryContainer: const Color(0xFFD7DFB2),
      secondary: const Color(0xFF5E3974),
      tertiary: const Color(0xFF893789),
    ),
    ThemeModel(
      color: mango,
      primary: const Color(0xFFC78D20),
      primaryContainer: const Color(0xFFDEB059),
      secondary: const Color(0xFF616247),
      tertiary: const Color(0xFF8D9440),
    ),
    ThemeModel(
      color: amber,
      primary: const Color(0xFFE65100),
      primaryContainer: const Color(0xFFFFCC80),
      secondary: const Color(0xFF2979FF),
      tertiary: const Color(0xFF2962FF),
    ),
  ];
}
