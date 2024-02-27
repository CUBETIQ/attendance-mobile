import 'package:timesync360/core/network/dio/dio_util.dart';
import 'package:timesync360/core/network/dio/endpoint.dart';
import 'package:timesync360/feature/auth/change_password/model/change_password_model.dart';
import 'package:dio/dio.dart';
import 'package:timesync360/utils/logger.dart';

class ChangePasswordService {
  static final _singleton = ChangePasswordService._internal();
  final dioInstance = DioUtil();

  factory ChangePasswordService() {
    return _singleton;
  }

  ChangePasswordService._internal() {
    Logs.t('[ChangePasswordService] Initialized');
  }

  Future<void> changeStaffPassword(
      {required String id, required String newPassword}) async {
    final data = {
      "newPassword": newPassword,
    };
    Response response = await dioInstance.dio.put(
      Endpoints.instance.change_staff_password + id,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception(response.data["message"]);
    }
  }

  Future<void> changeUserPassword(ChangePasswordModel input) async {
    final data = input.toJson();
    Response response = await dioInstance.dio.put(
      Endpoints.instance.change_password,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Change password failed");
    }
  }
}
