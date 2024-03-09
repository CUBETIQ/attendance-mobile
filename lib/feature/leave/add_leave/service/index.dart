import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/feature/leave/add_leave/model/create_leave_model.dart';
import 'package:dio/dio.dart';
import 'package:timesync/feature/leave/add_leave/model/update_leave_model.dart';
import 'package:timesync/utils/logger.dart';

class AddLeaveService {
  static final _singleton = AddLeaveService._internal();
  final dioInstance = DioUtil();

  factory AddLeaveService() {
    return _singleton;
  }

  AddLeaveService._internal() {
    Logs.t('[AddLeaveService] Initialized');
  }

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

  Future<void> updateLeave(String id, UpdateLeaveModel input) async {
    Response response = await dioInstance.dio.put(
      Endpoints.instance.leave + id,
      data: input.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception("Update leave failed");
    }
  }
}
