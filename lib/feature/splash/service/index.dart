import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class SplashService {
  DioUtil dioInstance = DioUtil();

  Future<Set<String>> refreshToken(String token) async {
    final String accessToken;
    final String refreshToken;
    Response response = await dioInstance.dio.post(
      Endpoints.instance.refreshToken,
      data: {
        "refreshToken": token,
      },
    );
    if (response.statusCode == 200) {
      accessToken = response.data["data"]["accessToken"];
      refreshToken = response.data["data"]["refreshToken"];
    } else {
      throw Exception(response.data["message"]);
    }
    return {accessToken, refreshToken};
  }
}
