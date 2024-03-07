import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/feature/home/admin_leave_request/model/change_leave_status.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

class AdminLeaveRequestService {
  static final _singleton = AdminLeaveRequestService._internal();
  final dioInstance = DioUtil();

  factory AdminLeaveRequestService() {
    return _singleton;
  }

  AdminLeaveRequestService._internal() {
    Logs.t('[AdminLeaveRequestService] Initialized');
  }

  Future<List<LeaveModel>> getAllLeave(
      {int? startDate, int? endDate, required String organizationId}) async {
    final List<LeaveModel>? leave;
    Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
      "startDate": startDate,
      "endDate": endDate,
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

  Future<void> changeLeaveStatus(
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
