import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

class StaffService {
  static final _singleton = StaffService._internal();
  final dioInstance = DioUtil();

  factory StaffService() {
    return _singleton;
  }

  StaffService._internal() {
    Logs.t('[StaffService] Initialized');
  }

  Future<List<UserModel>> getAllStaffs({required String organizationId}) async {
    final List<UserModel> staffs;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.staff,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      staffs = UserModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get all staff failed");
    }
    return staffs;
  }

  Future<void> deleteStaff(String id) async {
    Response response = await dioInstance.dio.delete(
      Endpoints.instance.staff + id,
    );
    if (response.statusCode != 200) {
      throw Exception("Delete staff failed");
    }
  }
}
