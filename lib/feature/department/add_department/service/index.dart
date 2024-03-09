import 'package:dio/dio.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/feature/department/add_department/model/add_department_model.dart';
import 'package:timesync/feature/department/add_department/model/edit_department_model.dart';
import 'package:timesync/utils/logger.dart';

class AddDepartmentService {
  static final _singleton = AddDepartmentService._internal();
  final dioInstance = DioUtil();

  factory AddDepartmentService() {
    return _singleton;
  }

  AddDepartmentService._internal() {
    Logs.t('[AddDepartmentService] Initialized');
  }

  Future<DepartmentModel> addDepartment(AddDepartmentModel input) async {
    final DepartmentModel department;
    Map<String, dynamic> inputData = input.toJson();
    Response response = await dioInstance.dio.post(
      Endpoints.instance.get_department,
      data: inputData,
    );
    if (response.statusCode == 201) {
      department = DepartmentModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Add department failed");
    }
    return department;
  }

  Future<void> updateDepartment(String id, EditDepartmentModel input) async {
    Map<String, dynamic> inputData = input.toJson();
    Response response = await dioInstance.dio.put(
      Endpoints.instance.get_department + id,
      data: inputData,
    );
    if (response.statusCode != 200) {
      throw Exception("Update department failed");
    }
  }
}
