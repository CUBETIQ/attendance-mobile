import 'package:timesync360/constants/time.dart';
import 'package:timesync360/core/database/local_path/app_path_controller.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/core/network/interceptor/auth_interceptor.dart';
import 'package:timesync360/core/network/interceptor/logger_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'interceptor/error_interceptor.dart';

class DioUtil {
  late Dio _dio;
  static final DioUtil _singleton = DioUtil._internal();

  factory DioUtil() {
    return _singleton;
  }

  // Singleton pattern
  DioUtil._internal() {
    _dio = Dio();
    _initialize();
  }

  Dio get dio => _dio;

  // Method for initializing Dio settings
  void _initialize() {
    //Interceptors
    final interceptors = <Interceptor>[
      if (kDebugMode) LoggerInterceptor(),
      AuthInterceptor(),
      ErrorInterceptor(_dio),
      DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(AppPathController.path),
          policy: CachePolicy.refreshForceCache,
          hitCacheOnErrorExcept: [],
          maxStale: const Duration(
            days: 1,
          ),
          priority: CachePriority.high,
          // allowPostMethod: true,
        ),
      ),
    ];
    _dio
      ..options = BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: AppTimeouts.connectTimeout),
        receiveTimeout: const Duration(seconds: AppTimeouts.receiveTimeout),
      )
      ..interceptors.addAll(interceptors);
  }
}
