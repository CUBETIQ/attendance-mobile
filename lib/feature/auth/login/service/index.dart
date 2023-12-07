import 'package:attendance_app/core/model/department_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/feature/auth/login/model/index.dart';
import 'package:dio/dio.dart';

class LoginService {
  DioUtil dioInstance = DioUtil();

  Future<Set<String>> login(LoginModel input) async {
    final String accessToken;
    final String refreshToken;
    Response response = await dioInstance.dio.post(
      Endpoints.instance.login,
      data: {
        "username": input.username,
        "password": input.password,
      },
    );
    if (response.statusCode == 200) {
      accessToken = response.data["data"]["accessToken"];
      refreshToken = response.data["data"]["refreshToken"];
    } else {
      throw Exception("Login failed");
    }
    return {accessToken, refreshToken};
  }

  Future<UserModel> fetchMe() async {
    final UserModel user;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_profile,
    );
    if (response.statusCode == 200) {
      user = UserModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Login failed");
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
      throw Exception("Get Position failed");
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
      throw Exception("Get Department failed");
    }
    return department;
  }
}
