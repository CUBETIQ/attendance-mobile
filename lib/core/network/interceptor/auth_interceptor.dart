import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final LocalStorageController localDataService =
        LocalStorageController.getInstance();
    final localData = await localDataService.get();
    if (localData?.accessToken != null && localData?.accessToken != "") {
      options.headers.addAll({
        'content-type': 'application/json',
        'Authorization': "Bearer ${localData?.accessToken}",
      });
    } else {
      options.headers.addAll({
        'content-type': 'application/json',
      });
    }
    return super.onRequest(options, handler);
  }
}
