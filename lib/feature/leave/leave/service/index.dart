import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/model/summary_leave_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:timesync360/utils/logger.dart';

class LeaveService {
  static final _singleton = LeaveService._internal();
  final dioInstance = DioUtil();

  factory LeaveService() {
    return _singleton;
  }

  LeaveService._internal() {
    Logs.t('[LeaveService] Initialized');
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

  Future<void> deleteLeave(String id) async {
    Response response =
        await dioInstance.dio.delete(Endpoints.instance.leave + id);
    if (response.statusCode != 200) {
      throw Exception("Delete leave failed");
    }
  }

  Future<List<SummaryLeaveModel>> getUserLeavSummarize(
      {int? startDate, int? endDate}) async {
    final List<SummaryLeaveModel> summaryLeaves;

    Map<String, dynamic> queryParameters = {
      "startDate": startDate,
      "endDate": endDate,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_leave_summarize,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      summaryLeaves = SummaryLeaveModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get task failed");
    }
    return summaryLeaves;
  }
}
