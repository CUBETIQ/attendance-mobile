import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timesync/utils/logger.dart';
import 'package:timesync/utils/string_util.dart';

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
    final payload =
        StringUtil.convertToJsonStringQuotes(raw: message.payload ?? "{}");
    final decodedPayload = json.decode(payload);
    handlePayload(decodedPayload["type"]);
  }

  static void handlePayload(String? key) {
    // final currentRoute = Get.currentRoute;
    // final userId = AppConfig.getLocalData?.userId;
  }
}
