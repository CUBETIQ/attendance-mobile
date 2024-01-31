import 'dart:io';
import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync360/core/database/isar/entities/local_storage.dart';
import 'package:timesync360/core/database/isar/service/isar_service.dart';
import 'package:timesync360/core/model/activation_model.dart';
import 'package:timesync360/core/model/organization_model.dart';
import 'package:timesync360/core/widgets/debouncer/debouncer.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/auth/activation/model/activation_model.dart';
import 'package:timesync360/feature/auth/activation/service/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivationController extends GetxController {
  static ActivationController get to => Get.find();
  TextEditingController activationController = TextEditingController();
  final String title = "Please enter the activation code";
  final String description =
      "To unlock the flow of time with TimeSync360: Where every moment counts, and attendance becomes a seamless journey through the fabric of efficiency.";
  Rxn<ActivationModel> activate = Rxn<ActivationModel>(null);
  Rxn<AndroidDeviceInfo> androidInfo = Rxn<AndroidDeviceInfo>(null);
  Rxn<IosDeviceInfo> iosInfo = Rxn<IosDeviceInfo>(null);
  Rxn<String> device = Rxn<String>(null);
  final LocalStorageController localDataService =
      LocalStorageController.getInstance();
  Rx<LocalStorage> localData = LocalStorage().obs;
  Rxn<OrganizationModel> organization = Rxn<OrganizationModel>(null);
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void onInit() {
    super.onInit();
    initDevice();
  }

  Future<void> activation() async {
    validate();
    _debouncer.run(() async {});
    final data = await localDataService.get();
    if (MyTextFieldFormController.findController('Activation').isValid) {
      try {
        ActivateModel input = ActivateModel(
          code: activationController.text.toUpperCase(),
          device: device.value,
        );
        activate.value = await ActivationService().activate(input);
        await IsarService().saveLocalData(
          isActivated: true,
          organizationId: activate.value!.organizationId,
        );
        if (data?.isFirstTime != false) {
          Get.offNamed(Routes.ONBOARD);
        } else {
          Get.offNamed(Routes.LOGIN);
        }
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  Future<void> initDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidInfo.value = await deviceInfo.androidInfo;
      device.value = {
        "Model": androidInfo.value!.model,
        "Device": androidInfo.value!.device,
        "Version": androidInfo.value!.version.release
      }.toString();
    } else if (Platform.isIOS) {
      iosInfo.value = await deviceInfo.iosInfo;
      device.value = {
        "Model": iosInfo.value!.model,
        "Device": iosInfo.value!.name,
        "Version": iosInfo.value!.systemVersion,
      }.toString();
    }
  }

  void validate() {
    MyTextFieldFormController.findController('Activation').isValid;
  }
}
