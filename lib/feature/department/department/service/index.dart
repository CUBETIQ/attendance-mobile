import 'package:dio/dio.dart';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/utils/logger.dart';

class DepartmentService {
  static final _singleton = DepartmentService._internal();
  final dioInstance = DioUtil();

  factory DepartmentService() {
    return _singleton;
  }

  DepartmentService._internal() {
    Logs.t('[DepartmentService] Initialized');
  }

  Future<List<DepartmentModel>> getAllDepartment(
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
      throw Exception("Get All Department failed");
    }
    return departments;
  }

  Future<void> deleteDepartment(String id) async {
    Response response = await dioInstance.dio.delete(
      Endpoints.instance.get_department + id,
    );
    if (response.statusCode != 200) {
      throw Exception("Delete department failed");
    }
  }
}
