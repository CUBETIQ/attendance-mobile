import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/staff/add_staff/model/create_staff_model.dart';
import 'package:dio/dio.dart';

class AddStaffService {
  DioUtil dioInstance = DioUtil();

  Future<void> addStaff(CreateStaffModel input) async {
    final Map<String, dynamic> data = input.toJson();
    Response response = await dioInstance.dio.put(
      Endpoints.instance.staff,
      data: data,
    );
    if (response.statusCode == 200) {
      showSuccessSnackBar("Success", response.data["message"]);
    } else {
      throw Exception("Create staff failed");
    }
  }
}
