// ignore_for_file: constant_identifier_names

import 'package:attendance_app/feature/auth/login/login_binding.dart';
import 'package:attendance_app/feature/auth/login/view/index.dart';
import 'package:attendance_app/feature/onboard/onboard_binding.dart';
import 'package:attendance_app/feature/onboard/view/index.dart';
import 'package:attendance_app/feature/splash/splash_binding.dart';
import 'package:attendance_app/feature/splash/view/index.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARD,
      page: () => const OnBoardView(),
      binding: OnBoardBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
