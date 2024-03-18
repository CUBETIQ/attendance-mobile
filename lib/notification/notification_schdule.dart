import 'package:timesync/constants/time.dart';
import 'package:timesync/notification/notification_service.dart';
import 'package:timesync/utils/logger.dart';

class NotificationSchedule {
  static final NotificationSchedule _instance =
      NotificationSchedule._internal();

  factory NotificationSchedule() => _instance;

  NotificationSchedule._internal();

  static const int checkInId = 100;
  static const int checkOutId = 101;

  static Future<void> checkInReminder({String? time}) async {
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
        scheduledNotificationDateTime:
            AppTime.scheduleTimeForCheckin(hour: hour, min: min),
        id: checkInId,
      );
    } catch (e) {
      Logs.e(e);
    }
  }

  static Future<void> checkOutReminder({String? time}) async {
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
        scheduledNotificationDateTime:
            AppTime.scheduleTimeForCheckout(hour: hour, min: min),
        id: checkOutId,
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
