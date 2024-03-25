import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/notification_type.dart';
import 'package:timesync/core/model/notification_model.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/task/task/controller/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/logger.dart';

import '../core/database/isar/controller/local_storage_controller.dart';

class NotifyRoutePage {
  static final NotifyRoutePage instance = NotifyRoutePage._();

  factory NotifyRoutePage() => instance;
  final localDB = LocalStorageController.getInstance();

  NotifyRoutePage._();

  static void pushToOtherPagesFromBackground(RemoteMessage message) async {
    Logs.e('pushToOtherPagesFromBackground: ${message.data}');
    final payload = message.data;
    handlePayload(payload);
  }

  static void pushToOtherPagesFromForeground(
      NotificationResponse message) async {
    Logs.e('pushToOtherPagesFromForeground: ${message.payload}');
    if (message.payload == null || message.payload?.isEmpty == true) return;
    final decodedPayload = json.decode(message.payload!);
    handlePayload(decodedPayload);
  }

  static void handlePayload(dynamic json) {
    final data = NotificationPayloadModel.fromJson(json);
    final type = data.payload?.type;
    final subType = data.payload?.data?.subtype;
    Logs.e('handlePayload: ${data.payload?.type}');
    if (type == NotificationType.checkIn || type == NotificationType.checkOut) {
      if (subType == NotificationSubType.checkInLate ||
          subType == NotificationSubType.checkOutLate) {
        _handleCheckInOut();
      }
    } else if (type == NotificationType.task) {
      _handleTask(data);
    }
  }

  static void _handleCheckInOut() {
    if (Get.isRegistered<NavigationController>()) {
      Get.offNamed(Routes.NAVIGATION);

      if (NavigationController.to.selectedIndex.value != 0) {
        NavigationController.to.selectedIndex.value = 0;
      }
      if (NavigationController.to.getUserRole.value == Role.admin) {
        HomeController.to.tabController?.animateTo(1);
      }
    }
  }

  static void _handleTask(NotificationPayloadModel data) {
    String? id = data.payload?.data?.prop?["id"];
    TaskModel? task;
    if (id == null) return;

    if (Get.isRegistered<NavigationController>()) {
      Get.offNamed(Routes.NAVIGATION);

      if (NavigationController.to.selectedIndex.value != 2) {
        NavigationController.to.selectedIndex.value = 2;
      }

      if (Get.isRegistered<TaskController>()) {
        task = TaskController.to.tasks
            .firstWhereOrNull((element) => element.id == id);
        if (task != null) {
          TaskController.to.onTapTask(task);
        }
      }
    }
  }
}
