import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

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
        'User-Agent': AppConfig.getUserAgent,
        'x-organization-id':
            AppConfig.getLocalData?.organizationId ?? "default",
      });
    } else {
      options.headers.addAll({
        'content-type': 'application/json',
        'User-Agent': AppConfig.getUserAgent,
        'x-organization-id':
            AppConfig.getLocalData?.organizationId ?? "default",
      });
    }
    Logs.i(options.headers.toString());
    return super.onRequest(options, handler);
  }
}
