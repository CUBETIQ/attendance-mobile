import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/feature/auth/change_password/model/chnage_password_model.dart';
import 'package:dio/dio.dart';

class ChangePasswordService {
  DioUtil dioInstance = DioUtil();

  Future<void> changeStaffPassword(
      {required String id, required String newPassword}) async {
    final Map<String, dynamic> data = {
      "newPassword": newPassword,
    };
    Response response = await dioInstance.dio.put(
      Endpoints.instance.change_staff_password + id,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Change password failed");
    }
  }

  Future<void> changeUserPassword(ChangePasswordModel input) async {
    final Map<String, dynamic> data = {
      "oldPassword": input.oldPassword,
      "newPassword": input.newPassword,
    };
    Response response = await dioInstance.dio.put(
      Endpoints.instance.change_password,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Change password failed");
    }
  }
}
