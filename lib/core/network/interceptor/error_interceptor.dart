import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  final Dio _dio;
  final LocalStorageController localDataService = LocalStorageController();
  ErrorInterceptor(this._dio);

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response!.statusCode == 401 &&
        err.response?.data["message"] == "Token expired") {
      final data = await localDataService.get();
      final token = data?.refreshToken ?? "1234567@qwerty";
      try {
        final newToken = await refreshToken(token);

        // Replace the expired token with the new one in the original request headers
        err.requestOptions.headers['Authorization'] =
            'Bearer ${newToken.first}}';

        // Retry the original request with the new token
        return _dio.fetch(err.requestOptions);
      } catch (refreshError) {
        rethrow;
      }
    }
    return super.onError(err, handler);
  }

  Future<Set<String>> refreshToken(String token) async {
    DioUtil dioInstance = DioUtil();

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
      await IsarService()
          .saveLocalData(accessToken: accessToken, refreshToken: refreshToken);
    } else {
      throw Exception(response.data["message"]);
    }
    return {accessToken, refreshToken};
  }
}
