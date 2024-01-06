// ignore_for_file: non_constant_identifier_names

class Endpoints {
  Endpoints._();

  static final Endpoints _instance = Endpoints._();

  static Endpoints get instance => _instance;

  static const String baseUrl = "http://192.168.1.102:3000/api";

  String get login => "/auth/login";
  String get refreshToken => "/auth/token";
  String get activation => "/auth/activation/activate";
  String get deactivation => "/auth/activation/deactivate";
  String get validate_organization => "/auth/organization/";
  String get get_own_profile => "/auth/profile/me";
  String get update_profile => "/auth/profile/update";
  String get check_in => "/app/attendances/checkin";
  String get check_out => "/app/attendances/checkout";
  String get get_position => "/app/positions/";
  String get get_department => "/app/departments/";
  String get get_own_attendance => "/app/attendances/me";
  String get get_organization => "/app/organizations/";
  String get get_own_summary_attendance => "/app/summarize-attendances/me";
  String get get_own_task => "/app/tasks/me";
  String get get_own_task_summarize => "/app/summarize-tasks/me";
  String get task => "/app/tasks/";
  String get complete_task => "/app/tasks/status/";
  String get get_own_leave => "/app/leaves/me";
  String get get_own_leave_summarize => "/app/summarize-leaves/me";
  String get leave => "/app/leaves/";
  String get get_dashboard_chart => "/app/attendance-charts";
  String get get_all_staff => "/app/staffs";
}
