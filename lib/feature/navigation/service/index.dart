import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class NavigationService {
  DioUtil dioInstance = DioUtil();

  Future<UserModel> fetchMe() async {
    final UserModel user;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_own_profile,
    );
    if (response.statusCode == 200) {
      user = UserModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Login failed");
    }
    return user;
  }
}
