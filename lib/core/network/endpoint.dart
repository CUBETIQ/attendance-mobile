// ignore_for_file: non_constant_identifier_names

class Endpoints {
  Endpoints._();

  static final Endpoints _instance = Endpoints._();

  static Endpoints get instance => _instance;

  static const String baseUrl = "http://192.168.1.102:3000/api";

  // static const String baseUrl = "https://attendance-api-devx1.ctdn.dev/api";

  String get login => "/auth/login";
  String get refreshToken => "/auth/token";
  String get activation => "/auth/activation/activate";
  String get deactivation => "/auth/activation/deactivate";
  String get validate_organization => "/auth/organization/";
  String get get_user_profile => "/auth/profile/me";
  String get update_profile => "/auth/profile/update";
  String get change_password => "/auth/profile/password";
  String get user_status => "/auth/user-status";
  String get check_in => "/app/attendances/checkin";
  String get check_out => "/app/attendances/checkout";
  String get get_position => "/app/positions/";
  String get organization => "/app/organizations/";
  String get get_department => "/app/departments/";
  String get category => "/app/categories/";
  String get categoryType => "/app/categories/type";
  String get get_user_attendance => "/app/attendances/me";
  String get get_all_staff_attendance => "/app/attendances";
  String get get_organization => "/app/organizations/";
  String get get_user_summary_attendance => "/app/summarize-attendances/me";
  String get get_user_task => "/app/tasks/me";
  String get get_user_task_summarize => "/app/summarize-tasks/me";
  String get task => "/app/tasks/";
  String get complete_task => "/app/tasks/status/";
  String get get_user_leave => "/app/leaves/me";
  String get get_user_leave_summarize => "/app/summarize-leaves/me";
  String get leave => "/app/leaves/";
  String get change_leave_status => "/app/leaves/status/";
  String get get_dashboard_chart => "/app/attendance-charts";
  String get staff => "/app/staffs/";
  String get change_staff_password => "/app/staffs/password/";
  String get get_staff_attendance_report =>
      "/app/admin-reports/attendance-report";
  String get get_staff_task_report => "/app/admin-reports/task-report";
  String get get_staff_leave_report => "/app/admin-reports/leave-report";
  String get get_translation => "/app/translate";
}
