import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:timesync/feature/home/admin_leave_request/model/change_leave_status.dart';
import 'package:timesync/utils/logger.dart';

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

  Future<void> cancelLeave(
      {required ChangeLeaveStatusModel input, required String id}) async {
    Map<String, dynamic> inputData = input.toJson();
    Response response = await dioInstance.dio.put(
      Endpoints.instance.change_leave_status + id,
      data: inputData,
    );
    if (response.statusCode != 200) {
      throw Exception("Update leave status failed");
    }
  }
}
