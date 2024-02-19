import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/model/organization_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/model/user_status_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/auth/login/model/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:timesync360/utils/logger.dart';

class LoginService {
  static final _singleton = LoginService._internal();
  final dioInstance = DioUtil();

  factory LoginService() {
    return _singleton;
  }

  LoginService._internal() {
    Logs.t('[LoginService] Initialized');
  }

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
      Endpoints.instance.get_user_profile,
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

  Future<UserStatusModel> getUserStatus() async {
    final UserStatusModel? status;
    dio.Response response = await dioInstance.dio.get(
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
