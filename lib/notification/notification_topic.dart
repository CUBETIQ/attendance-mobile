import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timesync/utils/logger.dart';

class NotificationTopic {
  NotificationTopic._();
  static final NotificationTopic _instance = NotificationTopic._();
  factory NotificationTopic() => _instance;

  // Variables
  static final List<String> _subscribedTopics = [];
  static List<String> get subscribedTopics => _subscribedTopics;

  static bool isDevelopment = false;
  static String get prefix =>
      '${isDevelopment == true ? 'dev_' : ''}push_notification_';

  // Topics
  static String allDevicesTopic = '${prefix}all_devices';

  static String getPlatformDevicesTopic(
      {required bool isIOS, required String? version}) {
    return '$prefix${isIOS ? 'ios' : 'android'}_devices_$version';
  }

  static String getUserTypeTopic({required bool isAdmin, required String? id}) {
    return '$prefix${isAdmin ? 'admin' : 'staff'}_$id';
  }

  // Functions
  static subscribe(List<String> topics) {
    for (var topic in topics) {
      if (topic.isNotEmpty) {
        if (_subscribedTopics.contains(topic)) {
          Logs.t(
              '[subscribeToTopic] Already subscribed to topic: $topic, just skip');
          continue;
        }
        _subscribedTopics.add(topic);
        FirebaseMessaging.instance.subscribeToTopic(topic);
      } else {
        Logs.t('[subscribeToTopic] Topic is empty, just skip');
      }
    }
  }

  static unsubscribe(List<String> topics) {
    for (var topic in topics) {
      if (topic.isNotEmpty) {
        if (_subscribedTopics.contains(topic)) {
          Logs.t(
              '[unsubscribeToTopic] Already unsubscribed to topic: $topic, just skip');
          continue;
        }
        _subscribedTopics.remove(topic);
        FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      } else {
        Logs.t('[unsubscribeToTopic] Topic is empty, just skip');
      }
    }
  }

  static unsubscribeAll() {
    for (var topic in _subscribedTopics) {
      if (topic.isNotEmpty) {
        _subscribedTopics.remove(topic);
        FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      }
    }
  }
}
