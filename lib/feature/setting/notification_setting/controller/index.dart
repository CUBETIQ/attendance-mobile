import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/notification/notification_service.dart';

class NotificationController extends GetxController {
  final isEnableNotification = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotification();
  }

  Future<void> getNotification() async {
    isEnableNotification.value =
        AppConfig.getLocalData?.isEnableNotification ?? true;
  }

  Future<void> updateNotification(bool value) async {
    AppConfig.getLocalData?.isEnableNotification = value;
    AppConfig.setConfig(AppConfig.getLocalData);
    await IsarService().saveLocalData(
      input: LocalStorageModel(
        isEnableNotification: value,
      ),
    );
    isEnableNotification.value = value;
    NotificationIntegration.initializeInApplication();
  }
}
