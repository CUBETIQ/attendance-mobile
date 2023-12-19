import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/model/department_model.dart';
import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class SplashService {
  DioUtil dioInstance = DioUtil();

  Future<OrganizationModel> validateOrganization({required String id}) async {
    final OrganizationModel organization;
    dio.Response response = await dioInstance.dio.get(
      Endpoints.instance.validate_organization + id,
    );
    if (response.statusCode == 200) {
      organization = OrganizationModel().fromJson(response.data["data"]);
    } else {
      Get.offNamed(Routes.ACTIVATION);
      await IsarService().clearLocalData(
        unactivate: true,
        deleteToken: true,
      );
      return throw Exception(response.data["message"]);
    }
    return organization;
  }

  Future<UserModel> fetchMe() async {
    final UserModel user;
    dio.Response response = await dioInstance.dio.get(
      Endpoints.instance.get_own_profile,
    );
    if (response.statusCode == 200) {
      user = UserModel().fromJson(response.data["data"]);
    } else {
      return throw Exception(response.data["message"]);
    }
    return user;
  }

  Future<PositionModel> getPosition(String id) async {
    final PositionModel position;
    dio.Response response = await dioInstance.dio.get(
      Endpoints.instance.get_position + id,
    );
    if (response.statusCode == 200) {
      position = PositionModel().fromJson(response.data["data"]);
    } else {
      return throw Exception(response.data["message"]);
    }
    return position;
  }

  Future<DepartmentModel> getDepartment(String id) async {
    final DepartmentModel department;
    dio.Response response = await dioInstance.dio.get(
      Endpoints.instance.get_department + id,
    );
    if (response.statusCode == 200) {
      department = DepartmentModel().fromJson(response.data["data"]);
    } else {
      return throw Exception(response.data["message"]);
    }
    return department;
  }
}
