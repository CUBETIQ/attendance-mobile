import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';

class NavigationService {
  DioUtil dioInstance = DioUtil();

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
}
