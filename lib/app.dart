import 'package:attendance_app/core/translation/translation_service.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_utils/get_utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tracker",
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      localizationsDelegates: ServiceTranslation().delegates,
      translations: ServiceTranslation(),
      locale: Get.locale,
      fallbackLocale: const Locale('en'),
      getPages: AppPages.routes,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
    );
  }
}
