import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class NavigationService {
  DioUtil dioInstance = DioUtil();
  late bool isLocationServiceEnabled;
  late LocationPermission permission;

  Future<Position> getCurrentLocation() async {
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (!isLocationServiceEnabled) {
      return throw Exception("Please enable location service");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Future.delayed(const Duration(seconds: 1), () {
        openAppSettings();
      });
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<UserModel> fetchMe() async {
    final UserModel? user;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_profile,
    );
    if (response.statusCode == 200) {
      user = UserModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Get user failed");
    }
    return user;
  }
}
