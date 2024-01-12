import 'package:attendance_app/core/translation/translation_service.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tracker",
      defaultTransition: Transition.cupertino,
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
