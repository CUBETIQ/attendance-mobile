import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // Add error handling logic here
    // For example, you can log the error or show a user-friendly message
    // Modify the error as needed

    if (err.response != null) {
      // The request was made and the server responded with a status code
      print('Dio Error Status Code: ${err.response!.statusCode}');
      print('Dio Error Response Data: ${err.response!.data}');
    } else {
      // Something went wrong in setting up or sending the request
      print('Dio Error Message: ${err.message}');
    }

    // You can perform additional error handling based on the error type, status code, etc.

    // Allow Dio to continue with its default error handling
    return super.onError(err, handler);
  }
}
