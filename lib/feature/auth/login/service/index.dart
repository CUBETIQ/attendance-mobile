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
}
