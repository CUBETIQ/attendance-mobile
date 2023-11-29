import 'package:attendance_app/config/time.dart';
import 'package:attendance_app/network/endpoint.dart';
import 'package:attendance_app/network/interceptor/auth_interceptor.dart';
import 'package:attendance_app/network/interceptor/logger_interceptor.dart';
import 'package:dio/dio.dart';

import 'interceptor/error_interceptor.dart';

class DioUtil {
  static final Dio _dio = Dio();

  // Default headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json'
  };

  // Singleton pattern
  static Dio get dio => _dio;

  // Method for initializing Dio settings
  static void initialize() {
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
