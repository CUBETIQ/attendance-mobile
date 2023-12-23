import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class LeaveService {
  DioUtil dioInstance = DioUtil();

  Future<List<LeaveModel>> getOwnLeave() async {
    final List<LeaveModel>? leave;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_own_leave,
    );
    if (response.statusCode == 200) {
      leave = LeaveModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get leave failed");
    }
    return leave;
  }

  Future<void> deleteLeave(String id) async {
    Response response = await dioInstance.dio.delete(
      Endpoints.instance.leave + id,
    );
    if (response.statusCode != 200) {
      throw Exception("Delete leave failed");
    }
  }
}
