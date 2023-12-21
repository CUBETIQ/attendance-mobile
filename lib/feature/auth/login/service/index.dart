import 'package:attendance_app/core/model/department_model.dart';
import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/auth/login/model/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class LoginService {
  DioUtil dioInstance = DioUtil();

  Future<Set<String>> login(LoginModel input) async {
    final String accessToken;

    final String refreshToken;

    final data = {
      "username": input.username,
      "password": input.password,
    };
    dio.Response response = await dioInstance.dio.post(
      Endpoints.instance.login,
      data: data,
    );
    if (response.statusCode == 200) {
      accessToken = response.data["data"]["accessToken"];
      refreshToken = response.data["data"]["refreshToken"];
    } else {
      showErrorSnackBar("Error", response.data["message"]);
      throw Exception("Login failed");
    }
    return {accessToken, refreshToken};
  }

  Future<UserModel> fetchMe() async {
    final UserModel? user;
    dio.Response response = await dioInstance.dio.get(
      Endpoints.instance.get_own_profile,
    );
    if (response.statusCode == 200) {
      user = UserModel().fromJson(response.data["data"]);
    } else {
      showErrorSnackBar("Error", response.data["message"]);
      throw Exception("Login failed");
    }
    return user;
  }

  Future<PositionModel> getPosition(String id) async {
    final PositionModel? position;
    dio.Response response = await dioInstance.dio.get(
      Endpoints.instance.get_position + id,
    );
    if (response.statusCode == 200) {
      position = PositionModel().fromJson(response.data["data"]);
    } else {
      showErrorSnackBar("Error", response.data["message"]);
      throw Exception("Get Position failed");
    }
    return position;
  }

  Future<DepartmentModel> getDepartment(String id) async {
    final DepartmentModel? department;
    dio.Response response = await dioInstance.dio.get(
      Endpoints.instance.get_department + id,
    );
    if (response.statusCode == 200) {
      department = DepartmentModel().fromJson(response.data["data"]);
    } else {
      showErrorSnackBar("Error", response.data["message"]);
      throw Exception("Get Department failed");
    }
    return department;
  }

  Future<OrganizationModel> getOrganization({required String id}) async {
    final OrganizationModel? organization;
    dio.Response response = await dioInstance.dio.get(
      Endpoints.instance.validate_organization + id,
    );
    if (response.statusCode == 200) {
      organization = OrganizationModel().fromJson(response.data["data"]);
    } else {
      Get.offNamed(Routes.ACTIVATION);
      showErrorSnackBar("Error", response.data["message"]);
      throw Exception("Get organization failed");
    }
    return organization;
  }
}
