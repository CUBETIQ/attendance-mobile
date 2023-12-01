import 'package:attendance_app/config/time.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/core/network/interceptor/auth_interceptor.dart';
import 'package:attendance_app/core/network/interceptor/logger_interceptor.dart';
import 'package:dio/dio.dart';

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
      LoggerInterceptor(),
      AuthInterceptor(),
      ErrorInterceptor(),
    ];

    _dio
      ..options = BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: connectTimeout),
        receiveTimeout: const Duration(seconds: receiveTimeout),
      )
      ..interceptors.addAll(interceptors);
  }
}
