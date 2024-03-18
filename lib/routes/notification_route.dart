import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/notification_type.dart';
import 'package:timesync/core/model/notification_model.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
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
    Logs.e('handlePayload: ${data.payload?.type}');
    if (data.payload?.type == NotificationType.checkIn) {
      if (data.payload?.data?.subtype == NotificationSubType.checkInLate) {
        handleCheckInOut();
      }
    } else if (data.payload?.type == NotificationType.checkOut) {
      if (data.payload?.data?.subtype == NotificationSubType.checkOutLate) {
        handleCheckInOut();
      }
    }
  }

  static void handleCheckInOut() {
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
}
