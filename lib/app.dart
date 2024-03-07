import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/translation/translation_service.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/theme/theme_data.dart';
import 'package:timesync/translate/controller/index.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LanguageController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tracker",
      defaultTransition: Transition.cupertino,
      themeMode: AppConfig.isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
