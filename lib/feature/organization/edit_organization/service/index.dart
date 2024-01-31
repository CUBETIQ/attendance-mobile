import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/feature/organization/edit_organization/model/update_organization_model.dart';
import 'package:dio/dio.dart';

class EditOrganizationService {
  DioUtil dioInstance = DioUtil();

  Future<void> updateOrganization(
      {required String id, required UpdateOrganizationModel input}) async {
    Map<String, dynamic> data = input.toJson();

    Response response = await dioInstance.dio.put(
      Endpoints.instance.organization + id,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Update organization failed");
    }
  }
}
