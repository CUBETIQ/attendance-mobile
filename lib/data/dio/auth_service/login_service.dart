import 'package:cubetiq_attendance_app/model/error_response/handle_response.dart';
import 'package:cubetiq_attendance_app/util/console.dart';
import 'package:dio/dio.dart';

class LoginService {
  Future<void> login(String username, String password) async {
    Dio dio = Dio();
    String url = "https://reqres.in/api/login";
    try {
      Response response = await dio
          .post(url, data: {"email": username, "password": password}).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw "TimeOut";
        },
      );
      if (response.data != null) {
        Console.log('Login Data', response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw HandleModel().fromMap(e.response!.data);
      }
      rethrow;
    }
  }
}
