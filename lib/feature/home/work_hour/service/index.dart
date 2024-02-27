import 'package:timesync360/core/model/attendance_model.dart';
import 'package:timesync360/core/network/dio/dio_util.dart';
import 'package:timesync360/core/network/dio/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:timesync360/utils/logger.dart';

class WorkHourService {
  static final _singleton = WorkHourService._internal();
  final dioInstance = DioUtil();

  factory WorkHourService() {
    return _singleton;
  }

  WorkHourService._internal() {
    Logs.t('[WorkHourService] Initialized');
  }

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
