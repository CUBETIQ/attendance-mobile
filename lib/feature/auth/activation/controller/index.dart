import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/entities/local_storage.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/model/activation_model.dart';
import 'package:timesync/core/model/organization_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/feature/auth/activation/model/activation_model.dart';
import 'package:timesync/feature/auth/activation/model/device_activation_model.dart';
import 'package:timesync/feature/auth/activation/service/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivationController extends GetxController {
  static ActivationController get to => Get.find();
  final activationController = TextEditingController();
  final title = "Enter the activation code";
  final description =
      "Enter the activation code to unlock TimeSync 360, an efficient tool that optimizes time management and streamlines attendance.";
  final activate = Rxn<ActivationModel>(null);
  final androidInfo = Rxn<AndroidDeviceInfo>(null);
  final iosInfo = Rxn<IosDeviceInfo>(null);
  final localDataService = LocalStorageController.getInstance();
  final localData = LocalStorage().obs;
  LocalStorageModel? localStorageData;
  final activationDevice = Rxn<DeviceActivationModel>(null);

  Future<void> activation() async {
    validate();
    final data = await localDataService.get();
    if (MyTextFieldFormController.findController('Activation').isValid) {
      try {
        ActivateModel inputData = ActivateModel(
          activationCode: activationController.text.toUpperCase(),
          deviceId: AppConfig.deviceId,
          deviceInfo: AppConfig.deviceInfo,
        );
        activate.value = await ActivationService().activate(inputData);
        localStorageData = LocalStorageModel(
          isActivated: true,
          deviceHash: activate.value!.deviceHash,
          organizationId: activate.value!.organizationId,
        );
        await IsarService().saveLocalData(
          input: localStorageData,
        );
        final activationDevice =
            await getActivationDevice(activate.value!.deviceHash);
        if (data?.isFirstTime != false) {
          Get.offNamed(
            Routes.ONBOARD,
            arguments: {
              "organization": OrganizationModel(
                name: activationDevice?.organization?.name,
                image: activationDevice?.organization?.image,
                id: activationDevice?.organization?.id,
              ),
            },
          );
        } else {
          Get.offNamed(Routes.LOGIN, arguments: {
            "organization": OrganizationModel(
              name: activationDevice?.organization?.name,
              image: activationDevice?.organization?.image,
              id: activationDevice?.organization?.id,
            ),
          });
        }
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  Future<DeviceActivationModel?> getActivationDevice(String? deviceHash) async {
    try {
      if (AppConfig.deviceId != null) {
        final deviceActivation =
            await ActivationService().getDeviceActivation(deviceHash ?? "");
        activationDevice.value = deviceActivation;
      }
      return activationDevice.value;
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void validate() {
    MyTextFieldFormController.findController('Activation').isValid;
  }
}
