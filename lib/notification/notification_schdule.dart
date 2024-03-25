import 'dart:convert';

import 'package:timesync/constants/notification_type.dart';
import 'package:timesync/constants/time.dart';
import 'package:timesync/core/model/notification_model.dart';
import 'package:timesync/notification/notification_service.dart';
import 'package:timesync/utils/logger.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationSchedule {
  static final NotificationSchedule _instance =
      NotificationSchedule._internal();

  factory NotificationSchedule() => _instance;

  NotificationSchedule._internal();

  static tz.TZDateTime now = tz.TZDateTime.now(tz.local);

  static const int checkInId = 100;
  static const int checkOutId = 101;

  static const bool noAlertSunday = true;

  static Future<void> checkInReminder(
      {String? time, int? id, bool? toNextDay}) async {
    int? hour;
    int? min;

    if (time != null) {
      final split = time.split(":");
      hour = int.tryParse(split[0]);
      min = int.tryParse(split[1]);
    }

    tz.TZDateTime? scheduledTime = AppTime.schedule(hour: hour, min: min);

    // If today is Sunday and noAlertSunday is true, then don't schedule the notification
    if (now.weekday == DateTime.sunday && noAlertSunday == true) {
      scheduledTime = null;

      // If the scheduled time is before the current time, then schedule it for the next day
    } else if (scheduledTime.isBefore(now) || toNextDay == true) {
      // If today is Saturday and noAlertSunday is true, then schedule it for Monday
      if (noAlertSunday == true && scheduledTime.weekday == DateTime.saturday) {
        scheduledTime = scheduledTime.add(const Duration(days: 2));
      } else {
        scheduledTime = scheduledTime.add(const Duration(days: 1));
      }
    }

    try {
      NotificationIntegration.scheduleNotification(
        title: "Reminder",
        body: "You have not checked in yet, please check in now",
        scheduledNotificationDateTime: scheduledTime,
        id: id ?? checkInId,
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

  static Future<void> checkOutReminder({String? time, int? id}) async {
    int? hour;
    int? min;

    if (time != null) {
      final split = time.split(":");
      hour = int.tryParse(split[0]);
      min = int.tryParse(split[1]);
    }

    tz.TZDateTime? scheduledTime = AppTime.schedule(hour: hour, min: min);

    try {
      NotificationIntegration.scheduleNotification(
        title: "Reminder",
        body: "You have not checked out yet, please check out now",
        scheduledNotificationDateTime: scheduledTime,
        id: id ?? checkOutId,
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
