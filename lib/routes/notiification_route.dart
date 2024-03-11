import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import '../core/database/isar/controller/local_storage_controller.dart';
import 'app_pages.dart';

class NotifyRoutePage {
  static final NotifyRoutePage instance = NotifyRoutePage._();

  factory NotifyRoutePage() => instance;
  final localDB = LocalStorageController.getInstance();

  NotifyRoutePage._();

  static void pushToOtherPagesFromBackground(RemoteMessage message) async {
    final data = message.data;
    final currentRoute = Get.currentRoute;
    final userId = AppConfig.getLocalData?.username;
    if (userId == null) {
      return;
    }
    if (data['type'] == "Notification") {
      Get.toNamed("$currentRoute/${Routes.NOTIFICATION}",
          arguments: {'userId': userId});
    }
  }

  static void pushToOtherPagesFromForeground(RemoteMessage message) async {
    final currentRoute = Get.currentRoute;
    final userId = AppConfig.getLocalData?.username;
    if (isTypeNotification(message, "Notification")) {
      Get.toNamed("$currentRoute/${Routes.NOTIFICATION}",
          arguments: {'userId': userId});
    }
  }

  static bool isTypeNotification(RemoteMessage message, String key) {
    final data = message.data;
    if (data.containsKey('type')) {
      return data['type'] == key;
    }
    return false;
  }
}
