import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:dio/dio.dart';
import '../../../core/network/endpoint.dart';

class OrganizationService {
  DioUtil dioInstance = DioUtil();

  Future<OrganizationModel> getOrganization({required String id}) async {
    final OrganizationModel? organization;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.organization + id,
    );
    if (response.statusCode == 200) {
      organization = OrganizationModel().fromJson(response.data["data"]);
    } else {
      showErrorSnackBar("Error", response.data["message"]);
      throw Exception("Get organization failed");
    }
    return organization;
  }

  Future<List<UserModel>> getAllStaffs({required String organizationId}) async {
    final List<UserModel> staffs;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.staff,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      staffs = UserModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get all staff failed");
    }
    return staffs;
  }
}
