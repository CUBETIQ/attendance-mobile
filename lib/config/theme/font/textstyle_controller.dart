import 'package:cubetiq_attendance_app/config/theme/app_theme.dart';
import 'package:cubetiq_attendance_app/config/theme/font/font_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextStyleController extends GetxController {
  static TextStyleController get to => Get.find();
  Rx<ThemeData> themeLight = light.obs;
  Rx<ThemeData> themeDark = dark.obs;
  ThemeData get lightTheme => themeLight.value;
  ThemeData get darkTheme => themeDark.value;
  @override
  void onInit() {
    super.onInit();
    getLanguageKey();
  }

  Future<void> getLanguageKey() async {
    String key = Get.locale!.languageCode;
    setLanguage(key);
  }

  void setLanguage(String language) {
    if (language == 'km') {
      FontManagement.setFontFamily('km');
      _updateTheme();
    } else {
      FontManagement.setFontFamily('en');
      _updateTheme();
    }
  }

  void _updateTheme() {
    themeDark.value = buildSchemeDarker();
    themeLight.value = buildSchemeLight();
    bool isDarkMode = Get.isDarkMode;
    Get.changeTheme(isDarkMode ? darkTheme : lightTheme);
  }
}
