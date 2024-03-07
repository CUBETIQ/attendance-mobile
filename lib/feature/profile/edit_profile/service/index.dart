import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/feature/profile/edit_profile/model/update_profile_model.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

class EditProfileService {
  static final _singleton = EditProfileService._internal();
  final dioInstance = DioUtil();

  factory EditProfileService() {
    return _singleton;
  }

  EditProfileService._internal() {
    Logs.t('[EditProfileService] Initialized');
  }

  Future<void> updateProfile(UpdateProfileModel input) async {
    final data = {
      "firstName": input.firstname,
      "lastName": input.lastname,
      "dateOfBirth": input.dob,
      "address": input.address,
      "image": input.image,
      'gender': input.gender,
    };
    Response response = await dioInstance.dio.put(
      Endpoints.instance.update_profile,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Login failed");
    }
  }
}
