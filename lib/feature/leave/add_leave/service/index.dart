import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/feature/leave/add_leave/model/create_leave_model.dart';
import 'package:dio/dio.dart';

class AddLeaveService {
  DioUtil dioInstance = DioUtil();

  Future<void> addLeave(CreateLeaveModel input, int date) async {
    Map<String, dynamic> data = {
      "leaveType": input.leaveType,
      "leaveReason": input.leaveReason,
      "leaveFrom": input.leaveFrom,
      "leaveTo": input.leaveTo,
      "leaveDurationType": input.leaveDurationType,
      "date": date
    };
    Response response = await dioInstance.dio.post(
      Endpoints.instance.leave,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Add leave failed");
    }
  }

  Future<void> updateLeave(String id, CreateLeaveModel input) async {
    final data = {
      "leaveType": input.leaveType,
      "leaveReason": input.leaveReason,
      "leaveFrom": input.leaveFrom,
      "leaveTo": input.leaveTo,
      "leaveDurationType": input.leaveDurationType,
    };
    Response response = await dioInstance.dio.put(
      Endpoints.instance.leave + id,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Update leave failed");
    }
  }
}
