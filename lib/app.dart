import 'package:cubetiq_attendance_app/config/routes/route_wrappers.dart';
import 'package:cubetiq_attendance_app/config/theme/font/textstyle_controller.dart';
import 'package:cubetiq_attendance_app/config/translation/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<TextStyleController>();
    return GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Stack(
            children: [
              child!,
              // const OverlayView(),
            ],
          ),
        );
      },
      smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      localizationsDelegates: ServiceTranslation().delegates,
      translations: ServiceTranslation(),
      locale: Get.locale,
      fallbackLocale: const Locale('en'),
      themeMode: ThemeMode.light,
      darkTheme: themeController.darkTheme,
      theme: themeController.lightTheme,
      getPages: Routes.routes,
      initialRoute: Routes.splash,
    );
  }
}
