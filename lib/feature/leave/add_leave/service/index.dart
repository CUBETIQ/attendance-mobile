import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/feature/leave/add_leave/model/create_leave_model.dart';
import 'package:dio/dio.dart';

class AddLeaveService {
  DioUtil dioInstance = DioUtil();

  Future<void> addLeave(CreateLeaveModel input) async {
    Map<String, dynamic> data = input.toJson();
    Response response = await dioInstance.dio.post(
      Endpoints.instance.leave,
      data: data,
    );
    if (response.statusCode != 201) {
      throw Exception("Add leave failed");
    }
  }

  Future<void> updateLeave(String id, CreateLeaveModel input) async {
    Response response = await dioInstance.dio.put(
      Endpoints.instance.leave + id,
      data: input.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception("Update leave failed");
    }
  }
}
