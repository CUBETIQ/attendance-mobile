import 'package:timesync360/core/model/admin_attendance_report_model.dart';
import 'package:timesync360/core/model/admin_leave_report_model.dart';
import 'package:timesync360/core/model/admin_task_report_model.dart';
import 'package:timesync360/core/model/attendance_model.dart';
import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/network/dio/dio_util.dart';
import 'package:timesync360/core/network/dio/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:timesync360/utils/logger.dart';

class ReportService {
  static final _singleton = ReportService._internal();
  final dioInstance = DioUtil();

  factory ReportService() {
    return _singleton;
  }

  ReportService._internal() {
    Logs.t('[ReportService] Initialized');
  }

  Future<List<AdminAttendanceReportModel>> getStaffAttendanceReport(
      {required String organizationId, int? startDate, int? endDate}) async {
    final List<AdminAttendanceReportModel>? staffReport;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
      "startDate": startDate,
      "endDate": endDate,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_staff_attendance_report,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      staffReport =
          AdminAttendanceReportModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Failed to get staff report");
    }
    return staffReport;
  }

  Future<List<AdminTaskReportModel>> getStaffTaskReport(
      {required String organizationId, int? startDate, int? endDate}) async {
    final List<AdminTaskReportModel>? staffReport;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
      "startDate": startDate,
      "endDate": endDate,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_staff_task_report,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      staffReport = AdminTaskReportModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Failed to get staff report");
    }
    return staffReport;
  }

  Future<List<AdminLeaveReportModel>> getStaffLeaveReport(
      {required String organizationId, int? startDate, int? endDate}) async {
    final List<AdminLeaveReportModel>? staffReport;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
      "startDate": startDate,
      "endDate": endDate,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_staff_leave_report,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      staffReport = AdminLeaveReportModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Failed to get staff report");
    }
    return staffReport;
  }

  Future<List<AttendanceModel>> getAttendance(
      {int? startDate, int? endDate}) async {
    List<AttendanceModel>? attendanceList = [];

    final query = {
      "startDate": startDate,
      "endDate": endDate,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_attendance,
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      attendanceList = AttendanceModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return attendanceList;
  }

  Future<List<LeaveModel>> getUserLeave({int? startDate, int? endDate}) async {
    final List<LeaveModel>? leave;
    Map<String, dynamic> queryParameters = {
      "startDate": startDate,
      "endDate": endDate,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_leave,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      leave = LeaveModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get leave failed");
    }
    return leave;
  }
}
