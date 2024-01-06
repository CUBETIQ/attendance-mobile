import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class StaffService {
  DioUtil dioInstance = DioUtil();

  Future<List<UserModel>> getAllStaffs({required String organizationId}) async {
    final List<UserModel> staffs;
    Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_all_staff,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      staffs = UserModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get all staff failed");
    }
    return staffs;
  }
}
