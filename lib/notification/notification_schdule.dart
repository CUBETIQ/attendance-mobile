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

  static Future<void> checkInReminder({int? hour, int? min}) async {
    try {
      NotificationIntegration.scheduleNotification(
        title: "Reminder",
        body: "You have not checked in yet, please check in now",
        scheduledNotificationDateTime: AppTime.scheduleTimeForCheckin,
        id: checkInId,
      );
    } catch (e) {
      Logs.e(e);
    }
  }

  static Future<void> checkOutReminder({int? hour, int? min}) async {
    try {
      NotificationIntegration.scheduleNotification(
        title: "Reminder",
        body: "You have not checked out yet, please check out now",
        scheduledNotificationDateTime: AppTime.scheduleTimeForCheckout,
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
