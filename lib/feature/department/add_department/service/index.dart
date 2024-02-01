import 'package:dio/dio.dart';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/feature/department/add_department/model/add_department_model.dart';
import 'package:timesync360/feature/department/add_department/model/edit_department_model.dart';

class AddDepartmentService {
  DioUtil dioInstance = DioUtil();

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
