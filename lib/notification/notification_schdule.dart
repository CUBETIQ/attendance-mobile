import 'dart:convert';

import 'package:timesync/constants/notification_type.dart';
import 'package:timesync/constants/time.dart';
import 'package:timesync/core/model/notification_model.dart';
import 'package:timesync/notification/notification_service.dart';
import 'package:timesync/utils/logger.dart';

class NotificationSchedule {
  static final NotificationSchedule _instance =
      NotificationSchedule._internal();

  factory NotificationSchedule() => _instance;

  NotificationSchedule._internal();

  static const int checkInId = 100;
  static const int checkOutId = 101;

  static Future<void> checkInReminder({String? time, bool? toNextDay}) async {
    int? hour;
    int? min;

    if (time != null) {
      final split = time.split(":");
      hour = int.parse(split[0]);
      min = int.parse(split[1]);
    }

    try {
      NotificationIntegration.scheduleNotification(
        title: "Reminder",
        body: "You have not checked in yet, please check in now",
        scheduledNotificationDateTime: AppTime.scheduleTimeForCheckin(
            hour: hour, min: min, toNextDay: toNextDay),
        id: checkInId,
        payLoad: jsonEncode(
          NotificationPayloadModel(
            payload: PayloadModel(
              type: NotificationType.checkIn,
              data: PayloadDataModel(
                  subtype: NotificationSubType.checkInLate, prop: {}),
            ),
          ).toJson(),
        ),
      );
    } catch (e) {
      Logs.e(e);
    }
  }

  static Future<void> checkOutReminder({String? time, bool? toNextDay}) async {
    int? hour;
    int? min;

    if (time != null) {
      final split = time.split(":");
      hour = int.parse(split[0]);
      min = int.parse(split[1]);
    }

    try {
      NotificationIntegration.scheduleNotification(
        title: "Reminder",
        body: "You have not checked out yet, please check out now",
        scheduledNotificationDateTime: AppTime.scheduleTimeForCheckout(
            hour: hour, min: min, toNextDay: toNextDay),
        id: checkOutId,
        payLoad: jsonEncode(
          NotificationPayloadModel(
            payload: PayloadModel(
              type: NotificationType.checkOut,
              data: PayloadDataModel(
                  subtype: NotificationSubType.checkOutLate, prop: {}),
            ),
          ).toJson(),
        ),
      );
    } catch (e) {
      Logs.e(e);
    }
  }

  static Future<void> cancelCheckInReminder() async {
    try {
      NotificationIntegration.cancelNotification(checkInId);
    } catch (e) {
      Logs.e(e);
    }
  }

  static Future<void> cancelCheckOutReminder() async {
    try {
      NotificationIntegration.cancelNotification(checkOutId);
    } catch (e) {
      Logs.e(e);
    }
  }

  static Future<void> cancelAllReminder() async {
    try {
      NotificationIntegration.cancelAllNotification();
    } catch (e) {
      Logs.e(e);
    }
  }
}
