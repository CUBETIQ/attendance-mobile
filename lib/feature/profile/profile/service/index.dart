import 'package:attendance_app/core/model/summary_attendance_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/endpoint.dart';

class ProfileService {
  DioUtil dioInstance = DioUtil();

  Future<List<SummaryAttendanceModel>> getSummrizeAttendance() async {
    List<SummaryAttendanceModel>? summaryAttendance;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_own_summary_attendance,
    );
    if (response.statusCode == 200) {
      summaryAttendance =
          SummaryAttendanceModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return summaryAttendance;
  }
}
