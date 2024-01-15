import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class WorkHourService {
  DioUtil dioInstance = DioUtil();

  Future<List<AttendanceModel>> getAllStaffAttendance({
    int? startDate,
    int? endDate,
    required String organizationId,
  }) async {
    List<AttendanceModel>? attendanceList;

    Map<String, dynamic> query = {
      "startDate": startDate,
      "endDate": endDate,
      "organizationId": organizationId,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_all_staff_attendance,
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      attendanceList = AttendanceModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return attendanceList;
  }
}
