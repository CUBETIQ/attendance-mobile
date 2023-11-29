import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'content-type': 'application/json',
    });
    return super.onRequest(options, handler);
  }
}
