import 'package:timesync/core/model/earn_point_model.dart';
import 'package:timesync/core/model/summary_attendance_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

import '../../../../core/network/dio/endpoint.dart';

class ProfileService {
  static final _singleton = ProfileService._internal();
  final dioInstance = DioUtil();

  factory ProfileService() {
    return _singleton;
  }

  ProfileService._internal() {
    Logs.t('[ProfileService] Initialized');
  }

  Future<List<SummaryAttendanceModel>> getSummrizeAttendance() async {
    List<SummaryAttendanceModel>? summaryAttendance;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_summary_attendance,
    );
    if (response.statusCode == 200) {
      summaryAttendance =
          SummaryAttendanceModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return summaryAttendance;
  }

  Future<EarnPointModel> getEarnPoint() async {
    EarnPointModel? earnPoint;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_earn_point,
    );
    if (response.statusCode == 200) {
      earnPoint = EarnPointModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Get earn point failed");
    }
    return earnPoint;
  }
}
