import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:timesync360/utils/logger.dart';

class StaffService {
  static final _singleton = StaffService._internal();
  final dioInstance = DioUtil();

  factory StaffService() {
    return _singleton;
  }

  StaffService._internal() {
    Logs.t('[StaffService] Initialized');
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

  Future<List<PositionModel>> getAllPosition(
      {required String organizationId}) async {
    final List<PositionModel>? positions;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_position,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      positions = PositionModel().fromListJson(response.data["data"]);
    } else {
      showErrorSnackBar("Error", response.data["message"]);
      throw Exception("Get All Position failed");
    }
    return positions;
  }

  Future<List<DepartmentModel>> getDepartment(
      {required String organizationId}) async {
    final List<DepartmentModel>? departments;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_department,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      departments = DepartmentModel().fromListJson(response.data["data"]);
    } else {
      showErrorSnackBar("Error", response.data["message"]);
      throw Exception("Get Department failed");
    }
    return departments;
  }

  Future<void> deleteStaff(String id) async {
    Response response = await dioInstance.dio.delete(
      Endpoints.instance.staff + id,
    );
    if (response.statusCode != 200) {
      throw Exception("Delete staff failed");
    }
  }
}
