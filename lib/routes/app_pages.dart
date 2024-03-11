// ignore_for_file: constant_identifier_names

import 'package:timesync/core/widgets/error_widget/error_view.dart';
import 'package:timesync/feature/auth/activation/activation_binding.dart';
import 'package:timesync/feature/auth/activation/view/index.dart';
import 'package:timesync/feature/auth/change_password/view/index.dart';
import 'package:timesync/feature/auth/login/login_binding.dart';
import 'package:timesync/feature/auth/login/view/index.dart';
import 'package:timesync/feature/avatar/view/index.dart';
import 'package:timesync/feature/category/add_category/view/index.dart';
import 'package:timesync/feature/category/category/category_binding.dart';
import 'package:timesync/feature/category/category/view/index.dart';
import 'package:timesync/feature/category/category_detail/category_binding.dart';
import 'package:timesync/feature/category/category_detail/view/index.dart';
import 'package:timesync/feature/customer_support/customer_support_binding.dart';
import 'package:timesync/feature/customer_support/view/index.dart';
import 'package:timesync/feature/department/add_department/view/index.dart';
import 'package:timesync/feature/department/department/department_binding.dart';
import 'package:timesync/feature/department/department/view/index.dart';
import 'package:timesync/feature/department/department_detail/department_detail_binding.dart';
import 'package:timesync/feature/department/department_detail/view/index.dart';
import 'package:timesync/feature/home/admin_leave_request/admin_leave_binding.dart';
import 'package:timesync/feature/home/admin_leave_request/view/index.dart';
import 'package:timesync/feature/home/home/home_binding.dart';
import 'package:timesync/feature/home/summary_attendance/summary_attendance_binding.dart';
import 'package:timesync/feature/home/summary_attendance/view/index.dart';
import 'package:timesync/feature/home/work_hour/view/index.dart';
import 'package:timesync/feature/home/work_hour/work_hour_binding.dart';
import 'package:timesync/feature/leave/add_leave/view/index.dart';
import 'package:timesync/feature/leave/leave/leave_binding.dart';
import 'package:timesync/feature/leave/leave_detail/leave_detail_binding.dart';
import 'package:timesync/feature/leave/leave_detail/view/index.dart';
import 'package:timesync/feature/navigation/naviation_binding.dart';
import 'package:timesync/feature/navigation/view/index.dart';
import 'package:timesync/feature/onboard/onboard_binding.dart';
import 'package:timesync/feature/onboard/view/index.dart';
import 'package:timesync/feature/organization/edit_organization/view/index.dart';
import 'package:timesync/feature/organization/organiziation/organization_binding.dart';
import 'package:timesync/feature/organization/organiziation/view/index.dart';
import 'package:timesync/feature/position/add_position/view/index.dart';
import 'package:timesync/feature/position/position/position_binding.dart';
import 'package:timesync/feature/position/position/view/index.dart';
import 'package:timesync/feature/position/position_detail/position_detail_binding.dart';
import 'package:timesync/feature/position/position_detail/view/index.dart';
import 'package:timesync/feature/profile/earn_point/earn_point_binding.dart';
import 'package:timesync/feature/profile/earn_point/view/index.dart';
import 'package:timesync/feature/profile/edit_profile/view/index.dart';
import 'package:timesync/feature/profile/profile/profile_binding.dart';
import 'package:timesync/feature/qr_scan/scan_qr_binding.dart';
import 'package:timesync/feature/qr_scan/view/index.dart';
import 'package:timesync/feature/report/report_binding.dart';
import 'package:timesync/feature/setting/change_theme/view/index.dart';
import 'package:timesync/feature/setting/choose_language/view/index.dart';
import 'package:timesync/feature/setting/setting/setting_binding.dart';
import 'package:timesync/feature/setting/setting/view/index.dart';
import 'package:timesync/feature/splash/splash_binding.dart';
import 'package:timesync/feature/splash/view/index.dart';
import 'package:timesync/feature/employee/add_employee/view/index.dart';
import 'package:timesync/feature/employee/employee/staff_binding.dart';
import 'package:timesync/feature/employee/employee/view/index.dart';
import 'package:timesync/feature/employee/employee_detail/view/index.dart';
import 'package:timesync/feature/task/add_task/view/index.dart';
import 'package:timesync/feature/task/task/task_binding.dart';
import 'package:timesync/feature/task/task_detail/task_binding.dart';
import 'package:timesync/feature/task/task_detail/view/index.dart';
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
    GetPage(
      name: Routes.ADD_POSITION,
      page: () => const AddPositionView(),
    ),
    GetPage(
      name: Routes.POSITION_DETAIL,
      page: () => const PositionDetailView(),
      binding: PositionDetailBinding(),
    ),
    GetPage(
      name: Routes.DEPARTMENT,
      page: () => const DepartmentView(),
      binding: DepartmentBinding(),
    ),
    GetPage(
      name: Routes.ADD_DEPARTMENT,
      page: () => const AddDepartmentView(),
    ),
    GetPage(
      name: Routes.DEPARTMENT_DETAIL,
      page: () => const DepartmentDetailView(),
      binding: DepartmentDetailBinding(),
    ),
    GetPage(
      name: Routes.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.ADD_CATEGORY,
      page: () => const AddCategoryView(),
    ),
    GetPage(
      name: Routes.CATEGORY_DETAIL,
      page: () => const CategoryDetailView(),
      binding: CategoryDetailBinding(),
    ),
    GetPage(
      name: Routes.POINT,
      page: () => const EarnPointView(),
      binding: EarnPointBinding(),
    ),
    GetPage(
      name: Routes.SCANQR,
      page: () => const ScanQRView(),
      binding: ScanQRBinding(),
    ),
    GetPage(
      name: Routes.THEME,
      page: () => const ChangeThemeView(),
    ),
  ];
}
