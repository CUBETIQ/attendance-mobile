import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/network/dio/dio_util.dart';
import 'package:timesync360/core/network/dio/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:timesync360/utils/logger.dart';

class SummaryAttendanceService {
  static final _singleton = SummaryAttendanceService._internal();
  final dioInstance = DioUtil();

  factory SummaryAttendanceService() {
    return _singleton;
  }

  SummaryAttendanceService._internal() {
    Logs.t('[SummaryAttendanceService] Initialized');
  }

  Future<List<LeaveModel>> getAllLeave(
      {int? startDate, int? endDate, required String organizationId}) async {
    final List<LeaveModel>? leave;
    Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
      "startDate": startDate,
      "endDate": endDate,
      "q": "status:approved",
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.leave,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      leave = LeaveModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get All leave failed");
    }
    return leave;
  }
}
