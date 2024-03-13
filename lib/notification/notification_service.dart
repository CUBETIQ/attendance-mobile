import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timesync/app_version.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/notification/notification_topic.dart';
import 'package:timesync/routes/notiification_route.dart';
import '../../firebase_options.dart';

class NotificationIntegration {
  static final NotificationIntegration _instance =
      NotificationIntegration._internal();

  factory NotificationIntegration() => _instance;

  NotificationIntegration._internal();

  static late AndroidNotificationChannel _channel;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    if (Firebase.apps.isNotEmpty) {
      return;
    }
    await Firebase.initializeApp(
      name: 'Timesync 365',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      ///User granted permission'
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      ///  User granted provisional permission
    } else {
      ///User declined or has not accepted permission
    }
  }

  static void _onListenMessageInBackground() {
    FirebaseMessaging.onMessageOpenedApp.listen(_receiveMessageByData);
  }

  static Future<void> requestSettings() async {
    _initSettings();
    _showIosNotification();
    await messaging.setAutoInitEnabled(true);
    requestPermission();
    initializeInApplication();
  }

  static void initializeNotificationBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await initializeFirebase();
  }

  static _receiveMessageByData(RemoteMessage message) {
    /// ==========> Start <==================
    /// This method to check type and push redirect page
    NotifyRoutePage.pushToOtherPagesFromBackground(message);

    /// ==========> end <====================
  }

  static Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _receiveMessageByData(initialMessage);
    }

    /// Stream listener
    _onListenMessageInBackground();
  }

  static Future<void> _initSettings() async {
    _channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    // Allow to auto init the messaging service
  }

  static Future<void> showAndroidNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      var androidPlatformChannel = const AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        autoCancel: true,
        icon: '@mipmap/ic_launcher',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      );
      var iosPlatformChannel = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannel,
        iOS: iosPlatformChannel,
      );
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: "Payload",
      );
      AndroidInitializationSettings initializationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      DarwinInitializationSettings initializationSettingsDraw =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) {},
      );
      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDraw,
      );
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
          NotifyRoutePage.pushToOtherPagesFromForeground(message);
        },
        onDidReceiveBackgroundNotificationResponse: (payload) async {},
      );
    }
  }

  static Future<void> _showIosNotification() async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static void onListenAndShowNotificationInForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showAndroidNotification(message);
    });
  }

  static Future<String?> getTokenFCM() async {
    if (Platform.isIOS) {
      final token = await messaging.getAPNSToken();
      return token;
    }
    final fcmToken = await messaging.getToken();
    return fcmToken;
  }

  static Future<void> initializeInApplication() async {
    if (AppConfig.getLocalData?.isEnableNotification == true) {
      NotificationIntegration.onListenAndShowNotificationInForeground();
      NotificationTopic.subscribe([
        NotificationTopic.allDevicesTopic,
        NotificationTopic.getPlatformDevicesTopic(
            isIOS: Platform.isIOS, version: AppVersion.version.toString())
      ]);
      await NotificationIntegration.setupInteractedMessage();
    } else {
      NotificationTopic.unsubscribeAll();
    }
  }
}
