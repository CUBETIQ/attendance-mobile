import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/feature/auth/login/model/index.dart';
import 'package:dio/dio.dart';

class LoginService {
  DioUtil dioInstance = DioUtil();

  Future<String> login(LoginModel input) async {
    final String accessToken;
    Response response = await dioInstance.dio.post(
      Endpoints.instance.login,
      data: {
        "username": input.username,
        "password": input.password,
      },
    );
    if (response.statusCode == 200) {
      accessToken = response.data["data"]["accessToken"];
    } else {
      throw Exception("Login failed");
    }
    return accessToken;
  }
}
