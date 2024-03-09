import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timesync/utils/logger.dart';
import 'package:timesync/utils/permission_handler.dart';

class NavigationService {
  static final _singleton = NavigationService._internal();
  final dioInstance = DioUtil();
  late bool isLocationServiceEnabled;

  factory NavigationService() {
    return _singleton;
  }

  NavigationService._internal() {
    Logs.t('[NavigationService] Initialized');
  }

  Future<Position?> getCurrentLocation() async {
    final locationPermission =
        await PermissonHandler.requestLocationPermission();
    if (locationPermission) {
      isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        return throw Exception("Please enable location service");
      }
      return await Geolocator.getCurrentPosition();
    }
    return null;
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
