import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/model/activation_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/feature/auth/activation/model/activation_model.dart';
import 'package:timesync/feature/auth/activation/model/device_activation_model.dart';
import 'package:timesync/utils/logger.dart';

class ActivationService {
  static final _singleton = ActivationService._internal();
  final dioInstance = DioUtil();
  final localDataService = LocalStorageController.getInstance();

  factory ActivationService() {
    return _singleton;
  }

  ActivationService._internal() {
    Logs.t('[ActivationService] Initialized');
  }

  Future<ActivationModel> activate(ActivateModel input) async {
    final ActivationModel? activateModel;
    final response = await dioInstance.dio.post(
      Endpoints.instance.activation,
      data: input.toJson(),
    );
    if (response.statusCode == 200) {
      activateModel = ActivationModel().fromJson(response.data["data"]);
    } else {
      return throw Exception("Activation failed");
    }
    return activateModel;
  }

  Future<DeviceActivationModel> getDeviceActivation(String deviceHash) async {
    final DeviceActivationModel? deviceActivationModel;
    final response = await dioInstance.dio.get(
      Endpoints.instance.deviceActivation + deviceHash,
    );
    if (response.statusCode == 200) {
      deviceActivationModel =
          DeviceActivationModel().fromJson(response.data["data"]);
    } else {
      return throw Exception("Get device activation failed");
    }
    return deviceActivationModel;
  }

  Future<bool> deactivate(String deviceHash) async {
    final response = await dioInstance.dio.delete(
      Endpoints.instance.deviceActivation + deviceHash,
    );
    if (response.statusCode != 200) {
      throw Exception("Activation failed");
    }
    return true;
  }
}
