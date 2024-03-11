import 'package:firebase_messaging/firebase_messaging.dart';

class SubscriptTopic {
  SubscriptTopic._();
  static final SubscriptTopic _instance = SubscriptTopic._();
  factory SubscriptTopic() => _instance;

  static const String all = 'all';
  static const String news = 'news';
  static const String event = 'event';
  static const String promotion = 'promotion';
  static const String system = 'system';
  static const String other = 'other';

  static const List<String> list = [
    all,
    news,
    event,
    promotion,
    system,
    other,
  ];

  static String getTopic(String topic) {
    switch (topic) {
      case 'all':
        return all;
      case 'news':
        return news;
      case 'event':
        return event;
      case 'promotion':
        return promotion;
      case 'system':
        return system;
      case 'other':
        return other;
      default:
        return all;
    }
  }

  static subscribe(String? topic) {
    if (topic != null) {
      FirebaseMessaging.instance.subscribeToTopic(topic);
    }
  }

  static unsubscribe(String? topic) {
    if (topic != null) {
      FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    }
  }

  static unsubscribeAll() {
    for (var topic in list) {
      FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    }
  }

  static subscribeAll() {
    for (var topic in list) {
      FirebaseMessaging.instance.subscribeToTopic(topic);
    }
  }
}
