import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/core/widgets/dialog/dialog.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/utils/logger.dart';

class ErrorInterceptor extends dio.Interceptor {
  final dio.Dio _dio;
  final LocalStorageController localDataService =
      LocalStorageController.getInstance();
  ErrorInterceptor(this._dio);

  @override
  Future onError(
      dio.DioException err, dio.ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError) {
      showErrorSnackBar("error", "No internet connection");
      if (Get.currentRoute == Routes.SPLASH) {
        Get.offNamed(Routes.ERROR);
      }
      return;
    }

    if (err.response != null &&
        err.response!.statusCode == 401 &&
        err.response?.data["message"] == "Token expired") {
      final data = await localDataService.get();
      final token = data?.refreshToken ?? "1234567@qwerty";
      try {
        // Check if the refresh token in isar is expired it will show session expired and navigate to login page
        bool hasExpired = JwtDecoder.isExpired(token);
        if (hasExpired) {
          await IsarService().clearLocalData(deleteToken: true);
          showSessionExpiredDialog();
          return;
        }

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

    if (err.response?.data["message"] == null) {
      Get.offNamed(Routes.ERROR);
    }

    Logs.e(err);

    return super.onError(err, handler);
  }

  Future<Set<String>> refreshToken(String token) async {
    DioUtil dioInstance = DioUtil();

    final String accessToken;
    final String refreshToken;

    LocalStorageModel? localStorageData;

    dio.Response response = await dioInstance.dio.post(
      Endpoints.instance.refreshToken,
      data: {
        "refreshToken": token,
      },
    );

    if (response.statusCode == 200) {
      accessToken = response.data["data"]["accessToken"];
      refreshToken = response.data["data"]["refreshToken"];
      localStorageData = LocalStorageModel(
          accessToken: accessToken, refreshToken: refreshToken);
      await IsarService.to.saveLocalData(input: localStorageData);
    } else {
      await IsarService().clearLocalData(deleteToken: true);
      Get.offNamed(Routes.LOGIN);
      throw Exception(response.data["message"]);
    }
    return {accessToken, refreshToken};
  }
}
