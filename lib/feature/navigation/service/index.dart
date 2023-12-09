import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:geolocator/geolocator.dart';

class NavigationService {
  DioUtil dioInstance = DioUtil();
  late bool isLocationServiceEnabled;
  late LocationPermission permission;

  Future<OrganizationModel> getOrganization({required String id}) async {
    final OrganizationModel organization;
    final response = await dioInstance.dio.get(
      Endpoints.instance.get_organization + id,
    );
    if (response.statusCode == 200) {
      organization = OrganizationModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Get organization failed");
    }
    return organization;
  }

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
