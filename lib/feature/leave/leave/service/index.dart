import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/model/summary_leave_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class LeaveService {
  DioUtil dioInstance = DioUtil();

  Future<List<LeaveModel>> getOwnLeave({int? startDate, int? endDate}) async {
    final List<LeaveModel>? leave;
    Map<String, dynamic> queryParameters = {
      "startDate": startDate,
      "endDate": endDate,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_own_leave,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      leave = LeaveModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get leave failed");
    }
    return leave;
  }

  Future<void> deleteLeave(String id, int date) async {
    Response response = await dioInstance.dio
        .delete(Endpoints.instance.leave + id, data: {"date": date});
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
      Endpoints.instance.get_own_leave_summarize,
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
