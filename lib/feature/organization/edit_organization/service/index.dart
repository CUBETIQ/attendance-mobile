import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/feature/organization/edit_organization/model/update_organization_model.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

class EditOrganizationService {
  static final _singleton = EditOrganizationService._internal();
  final dioInstance = DioUtil();

  factory EditOrganizationService() {
    return _singleton;
  }

  EditOrganizationService._internal() {
    Logs.t('[EditOrganizationService] Initialized');
  }

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
