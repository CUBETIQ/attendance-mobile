import 'package:attendance_app/core/network/dio_util.dart';
import 'package:geolocator/geolocator.dart';

class NavigationService {
  DioUtil dioInstance = DioUtil();
  late bool isLocationServiceEnabled;
  late LocationPermission permission;

  Future<Position> getCurrentLocation() async {
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return Future.error("Please enable location service");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }
}
