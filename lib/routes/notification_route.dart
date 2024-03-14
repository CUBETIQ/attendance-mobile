import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/utils/logger.dart';

import '../core/database/isar/controller/local_storage_controller.dart';

class NotifyRoutePage {
  static final NotifyRoutePage instance = NotifyRoutePage._();

  factory NotifyRoutePage() => instance;
  final localDB = LocalStorageController.getInstance();

  NotifyRoutePage._();

  static void pushToOtherPagesFromBackground(RemoteMessage message) async {
    final payload = message.data['type'].toString();
    Logs.e('pushToOtherPagesFromBackground: $payload');
    handlePayload(payload);
  }

  static void pushToOtherPagesFromForeground(
      NotificationResponse message) async {
    if (message.payload == null || message.payload?.isEmpty == true) return;
    Logs.e('pushToOtherPagesFromBackground: ${message.payload}');
    final payload = jsonDecode(message.payload ?? '');

    handlePayload(payload);
  }

  static void handlePayload(String? key) {
    final currentRoute = Get.currentRoute;
    final userId = AppConfig.getLocalData?.username;
    //TODO: handle payload
  }
}
