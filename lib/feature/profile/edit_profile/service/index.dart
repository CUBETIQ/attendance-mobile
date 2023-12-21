import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/profile/edit_profile/model/update_profile_model.dart';
import 'package:dio/dio.dart';

class EditProfileService {
  DioUtil dioInstance = DioUtil();

  Future<void> updateProfile(UpdateProfileModel input) async {
    final data = {
      "firstName": input.firstname,
      "lastName": input.lastname,
      "dateOfBirth": input.dob,
      "address": input.address,
      "image": input.image,
      "status": input.status,
      'gender': input.gender,
    };
    Response response = await dioInstance.dio.put(
      Endpoints.instance.update_profile,
      data: data,
    );
    if (response.statusCode == 200) {
      showSuccessSnackBar("Success", response.data["message"]);
    } else {
      throw Exception("Login failed");
    }
  }
}
