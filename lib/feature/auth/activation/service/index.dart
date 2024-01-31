import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync360/core/model/activation_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/feature/auth/activation/model/activation_model.dart';
import 'package:dio/dio.dart';

class ActivationService {
  DioUtil dioInstance = DioUtil();
  final LocalStorageController localDataService =
      LocalStorageController.getInstance();
  Future<ActivationModel> activate(ActivateModel input) async {
    final ActivationModel? activateModel;
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
