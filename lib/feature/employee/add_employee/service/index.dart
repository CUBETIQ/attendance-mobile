import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/feature/employee/add_employee/model/create_staff_model.dart';
import 'package:timesync360/feature/employee/add_employee/model/update_staff_model.dart';
import 'package:dio/dio.dart';
import 'package:timesync360/utils/logger.dart';

class AddStaffService {
  static final _singleton = AddStaffService._internal();
  final dioInstance = DioUtil();

  factory AddStaffService() {
    return _singleton;
  }

  AddStaffService._internal() {
    Logs.t('[AddStaffService] Initialized');
  }

  Future<void> addStaff(CreateStaffModel input) async {
    final Map<String, dynamic> data = input.toJson();
    Response response = await dioInstance.dio.post(
      Endpoints.instance.staff,
      data: data,
    );
    if (response.statusCode != 201) {
      throw Exception("Create staff failed");
    }
  }

  Future<void> updateStaff({
    required UpdateStaffModel input,
    required String id,
  }) async {
    final Map<String, dynamic> data = input.toJson();
    Response response = await dioInstance.dio.put(
      Endpoints.instance.staff + id,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Create staff failed");
    }
  }
}
