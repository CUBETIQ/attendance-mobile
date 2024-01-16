import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';

class ErrorInterceptor extends Dio.Interceptor {
  final Dio.Dio _dio;
  final LocalStorageController localDataService =
      LocalStorageController.getInstance();
  ErrorInterceptor(this._dio);

  @override
  Future onError(
      Dio.DioException err, Dio.ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response!.statusCode == 401 &&
        err.response?.data["message"] == "Token expired") {
      final data = await localDataService.get();
      final token = data?.refreshToken ?? "1234567@qwerty";
      try {
        await Future.delayed(const Duration(seconds: 20));
        final newToken = await refreshToken(token);

        // Replace the expired token with the new one in the original request headers
        err.requestOptions.headers['Authorization'] =
            'Bearer ${newToken.first}}';

        // Retry the original request with the new token]
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

    Dio.Response response = await dioInstance.dio.post(
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
      await IsarService().clearLocalData(deleteToken: true);
      Get.offNamed(Routes.LOGIN);
      throw Exception(response.data["message"]);
    }
    return {accessToken, refreshToken};
  }
}
