// ignore_for_file: constant_identifier_names

import 'package:attendance_app/core/widgets/error_widget/error_view.dart';
import 'package:attendance_app/feature/auth/activation/activation_binding.dart';
import 'package:attendance_app/feature/auth/activation/view/index.dart';
import 'package:attendance_app/feature/auth/change_password/view/index.dart';
import 'package:attendance_app/feature/auth/login/login_binding.dart';
import 'package:attendance_app/feature/auth/login/view/index.dart';
import 'package:attendance_app/feature/avatar/view/index.dart';
import 'package:attendance_app/feature/customer_support/customer_support_binding.dart';
import 'package:attendance_app/feature/customer_support/view/index.dart';
import 'package:attendance_app/feature/home/admin_leave_request/admin_leave_binding.dart';
import 'package:attendance_app/feature/home/admin_leave_request/view/index.dart';
import 'package:attendance_app/feature/home/home/home_binding.dart';
import 'package:attendance_app/feature/home/summary_attendance/summary_attendance_binding.dart';
import 'package:attendance_app/feature/home/summary_attendance/view/index.dart';
import 'package:attendance_app/feature/home/work_hour/view/index.dart';
import 'package:attendance_app/feature/home/work_hour/work_hour_binding.dart';
import 'package:attendance_app/feature/leave/add_leave/view/index.dart';
import 'package:attendance_app/feature/leave/leave/leave_binding.dart';
import 'package:attendance_app/feature/leave/leave_detail/leave_detail_binding.dart';
import 'package:attendance_app/feature/leave/leave_detail/view/index.dart';
import 'package:attendance_app/feature/navigation/naviation_binding.dart';
import 'package:attendance_app/feature/navigation/view/index.dart';
import 'package:attendance_app/feature/onboard/onboard_binding.dart';
import 'package:attendance_app/feature/onboard/view/index.dart';
import 'package:attendance_app/feature/organization/edit_organization/view/index.dart';
import 'package:attendance_app/feature/organization/organiziation/organization_binding.dart';
import 'package:attendance_app/feature/organization/organiziation/view/index.dart';
import 'package:attendance_app/feature/position/position/position_binding.dart';
import 'package:attendance_app/feature/position/position/view/index.dart';
import 'package:attendance_app/feature/profile/edit_profile/view/index.dart';
import 'package:attendance_app/feature/profile/profile/profile_binding.dart';
import 'package:attendance_app/feature/report/report_binding.dart';
import 'package:attendance_app/feature/setting/choose_language/view/index.dart';
import 'package:attendance_app/feature/setting/setting/setting_binding.dart';
import 'package:attendance_app/feature/setting/setting/view/index.dart';
import 'package:attendance_app/feature/splash/splash_binding.dart';
import 'package:attendance_app/feature/splash/view/index.dart';
import 'package:attendance_app/feature/employee/add_employee/view/index.dart';
import 'package:attendance_app/feature/employee/employee/staff_binding.dart';
import 'package:attendance_app/feature/employee/employee/view/index.dart';
import 'package:attendance_app/feature/employee/employee_detail/view/index.dart';
import 'package:attendance_app/feature/task/add_task/view/index.dart';
import 'package:attendance_app/feature/task/task/task_binding.dart';
import 'package:attendance_app/feature/task/task_detail/task_binding.dart';
import 'package:attendance_app/feature/task/task_detail/view/index.dart';
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
        ReportBinding(),
      ],
    ),
    GetPage(
      name: Routes.TASK_DETAIL,
      page: () => const TaskDetailView(),
      binding: TaskDetailBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_SUMMARY_ATTENDANCE,
      page: () => const SummaryAttendaceView(),
      binding: SummaryAttendanceBinding(),
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
    GetPage(
      name: Routes.STAFF,
      page: () => const StaffView(),
      binding: StaffBinding(),
    ),
    GetPage(
      name: Routes.STAFF_DETAIL,
      page: () => const StaffDetailView(),
    ),
    GetPage(
      name: Routes.ADD_STAFF,
      page: () => const AddStaffView(),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.ORGANIZATION,
      page: () => const OrganizationView(),
      binding: OrganizationBinding(),
    ),
    GetPage(
      name: Routes.EDIT_ORGANIZATION,
      page: () => const EditOrganizationView(),
    ),
    GetPage(
      name: Routes.ADMIN_LEAVE_REQUEST,
      page: () => const AdminLeaveRequestView(),
      binding: AdminLeaveRequestBinding(),
    ),
    GetPage(
      name: Routes.WORKING_HOUR,
      page: () => const WorkingHourView(),
      binding: WorkingHourBinding(),
    ),
    GetPage(
      name: Routes.AVATAR,
      page: () => const AvatarView(),
    ),
    GetPage(
      name: Routes.LANGUAGE,
      page: () => const ChangeLanguageView(),
    ),
    GetPage(
      name: Routes.ERROR,
      page: () => const ErrorView(),
    ),
    GetPage(
      name: Routes.CUSTOMER_SUPPORT,
      page: () => const CustomerSupportView(),
      binding: CustomerSupportBinding(),
    ),
    GetPage(
      name: Routes.POSITION,
      page: () => const PositionView(),
      binding: PositionBinding(),
    ),
  ];
}
