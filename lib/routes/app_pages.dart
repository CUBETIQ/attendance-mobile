// ignore_for_file: constant_identifier_names

import 'package:attendance_app/feature/auth/activation/activation_binding.dart';
import 'package:attendance_app/feature/auth/activation/view/index.dart';
import 'package:attendance_app/feature/auth/login/login_binding.dart';
import 'package:attendance_app/feature/auth/login/view/index.dart';
import 'package:attendance_app/feature/home/home/home_binding.dart';
import 'package:attendance_app/feature/leave/add_leave/view/index.dart';
import 'package:attendance_app/feature/leave/leave/leave_binding.dart';
import 'package:attendance_app/feature/leave/leave_detail/leave_detail_binding.dart';
import 'package:attendance_app/feature/leave/leave_detail/view/index.dart';
import 'package:attendance_app/feature/navigation/naviation_binding.dart';
import 'package:attendance_app/feature/navigation/view/index.dart';
import 'package:attendance_app/feature/onboard/onboard_binding.dart';
import 'package:attendance_app/feature/onboard/view/index.dart';
import 'package:attendance_app/feature/profile/edit_profile/view/index.dart';
import 'package:attendance_app/feature/profile/profile/profile_binding.dart';
import 'package:attendance_app/feature/splash/splash_binding.dart';
import 'package:attendance_app/feature/splash/view/index.dart';
import 'package:attendance_app/feature/task/add_task/view/index.dart';
import 'package:attendance_app/feature/task/task/task_binding.dart';
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
      name: Routes.ACTIVATION,
      page: () => const ActivationView(),
      binding: ActivationBinding(),
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
    GetPage(
      name: Routes.NAVIGATION,
      page: () => const NavigationView(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        ProfileBinding(),
        TaskBinding(),
        LeaveBinding(),
      ],
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => const EditProfileView(),
    ),
    GetPage(
      name: Routes.ADD_TASK,
      page: () => const AddTaskView(),
    ),
    GetPage(
      name: Routes.ADD_LEAVE,
      page: () => const AddLeaveView(),
    ),
    GetPage(
      name: Routes.LEAVE_DETAIL,
      page: () => const LeaveDetailView(),
      binding: LeaveDetailBinding(),
    ),
  ];
}
