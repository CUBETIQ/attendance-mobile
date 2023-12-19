import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/core/model/activation_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/feature/auth/activation/model/activation_model.dart';
import 'package:dio/dio.dart';

class ActivationService {
  DioUtil dioInstance = DioUtil();
  final LocalStorageController localDataService = LocalStorageController();
  Future<ActivationModel> activate(ActivateModel input) async {
    final ActivationModel activateModel;
    Response response = await dioInstance.dio.post(
      Endpoints.instance.activation,
      data: {
        "code": input.code,
        "device": input.device,
      },
    );
    if (response.statusCode == 200) {
      activateModel = ActivationModel().fromJson(response.data["data"]);
    } else {
      return throw Exception("Activation failed");
    }
    return activateModel;
  }
}
