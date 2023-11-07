// ignore_for_file: prefer_const_constructors

import 'package:cubetiq_attendance_app/view/splash/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  Routes._();

  static const splash = '/splash';
  static const login = '/login';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    // GetPage(
    //   name: login,
    //   page: () => LoginScreen(),
    //   binding: LoginBinding(),
    // ),
  ];
}
