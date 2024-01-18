import 'package:attendance_app/core/model/admin_attendance_report_model.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class ReportService {
  DioUtil dioInstance = DioUtil();

  Future<List<AdminReportModel>> getStaffReport(
      {required String organizationId, int? startDate, int? endDate}) async {
    final List<AdminReportModel>? staffReport;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
      "startDate": startDate,
      "endDate": endDate,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_staff_report,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      staffReport = AdminReportModel().fromListJson(response.data["data"]);
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
