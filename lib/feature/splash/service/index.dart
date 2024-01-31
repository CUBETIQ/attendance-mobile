import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/model/organization_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/model/user_status_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class SplashService {
  DioUtil dioInstance = DioUtil();

  Future<OrganizationModel> validateOrganization({required String id}) async {
    final OrganizationModel organization;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.validate_organization + id,
    );
    if (response.statusCode == 200) {
      organization = OrganizationModel().fromJson(response.data["data"]);
    } else {
      return throw Exception(response.data["message"]);
    }
    return organization;
  }

  Future<UserModel> fetchMe() async {
    final UserModel user;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_profile,
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
    Response response = await dioInstance.dio.get(
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
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_department + id,
    );
    if (response.statusCode == 200) {
      department = DepartmentModel().fromJson(response.data["data"]);
    } else {
      return throw Exception(response.data["message"]);
    }
    return department;
  }

  Future<UserStatusModel> getUserStatus() async {
    final UserStatusModel? status;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.user_status,
    );
    if (response.statusCode == 200) {
      status = UserStatusModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Get user status failed");
    }
    return status;
  }
}
