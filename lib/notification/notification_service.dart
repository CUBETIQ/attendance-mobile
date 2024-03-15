import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timesync/app_version.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/notification/notification_topic.dart';
import 'package:timesync/routes/notification_route.dart';
import 'package:timesync/utils/logger.dart';
import '../../firebase_options.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationIntegration {
  static final NotificationIntegration _instance =
      NotificationIntegration._internal();

  factory NotificationIntegration() => _instance;

  NotificationIntegration._internal();

  static AndroidNotificationChannel? _channel;
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeFirebase() async {
    if (Firebase.apps.isNotEmpty) {
      return;
    }
    await Firebase.initializeApp(
      name: 'Timesync 365',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> requestSettings() async {
    await _initSettings().then((value) {
      if (value != null) {
        initializeMessageListener(value);
      }
    });
    initializeInApplication();
  }

  static Future<InitializationSettings?> _initSettings() async {
    InitializationSettings? settings;
    if (Platform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      );

      settings = const InitializationSettings(
        iOS: initializationSettingsIOS,
      );
    } else {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      settings = const InitializationSettings(
        android: initializationSettingsAndroid,
      );
    }

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
        ?.createNotificationChannel(_channel!);

    // Allow to auto init the messaging service
    await messaging.setAutoInitEnabled(true);

    return settings;
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

  static Future<void> initializeInApplication() async {
    if (AppConfig.getLocalData?.isEnableNotification == true) {
      NotificationTopic.subscribe([
        NotificationTopic.allDevicesTopic,
        NotificationTopic.getPlatformDevicesTopic(
            isIOS: Platform.isIOS, version: AppVersion.version.toString())
      ]);
    } else {
      NotificationTopic.unsubscribeAll();
    }
  }

  static void initializeNotificationBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await initializeFirebase();
  }

  // Foreground Notification
  static Future<void> onListenAndShowNotificationInForeground(
      InitializationSettings settings) async {
    await _listenWithLocalPushNotification(settings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showAndroidNotification(message);
    });
  }

  //Background Notification
  static void _onListenMessageInBackground() {
    FirebaseMessaging.onMessageOpenedApp
        .listen(_receiveMessageBackgroundAndTerminated);
  }

  //Terminated Notification
  static Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _receiveMessageBackgroundAndTerminated(initialMessage);
    }
  }

  static _receiveMessageForeground(NotificationResponse message) {
    /// ==========> Start <==================
    /// This method to check type and push redirect page
    NotifyRoutePage.pushToOtherPagesFromForeground(message);

    /// ==========> end <====================
  }

  static _receiveMessageBackgroundAndTerminated(RemoteMessage message) {
    /// ==========> Start <==================
    /// This method to check type and push redirect page
    NotifyRoutePage.pushToOtherPagesFromBackground(message);

    /// ==========> end <====================
  }

  static Future<void> scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      DateTime? scheduledNotificationDateTime}) async {
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    Logs.e(tz.TZDateTime.now(tz.local).toString());
    return _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title ?? 'Timesync',
        body ?? 'Body',
        payload: 'payload',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(
          // Android details
          android: AndroidNotificationDetails(
              _channel?.id ?? 'high_importance_channel',
              _channel?.name ?? 'High Importance Notifications',
              channelDescription: _channel?.description,
              importance: Importance.max),
          // iOS details
          iOS: const DarwinNotificationDetails(),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  static Future<void> showAndroidNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && _channel != null) {
      _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel!.id,
              _channel!.name,
              channelDescription: _channel!.description,
              icon: android.smallIcon,
              // other properties...
            ),
          ),
          payload: message.data.toString());
    }
  }

  // NOTICE: This method is used to listen to the local push notification,
  // and handle the payload when the notification is clicked.
  static Future<void> _listenWithLocalPushNotification(
      InitializationSettings settings) async {
    await _flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: _receiveMessageForeground,
        onDidReceiveBackgroundNotificationResponse: _receiveMessageForeground);
  }

  static void showNotification(int id,
      {String? title,
      String? body,
      String? payload,
      AndroidNotificationDetails? androidDetails,
      DarwinNotificationDetails? iOSDetails}) {
    if (androidDetails == null && Platform.isAndroid) {
      androidDetails = AndroidNotificationDetails(
          _channel?.id ?? 'high_importance_channel',
          _channel?.name ?? 'High Importance Notifications',
          channelDescription: _channel?.description,
          importance: Importance.max);
    } else if (iOSDetails == null && Platform.isIOS) {
      iOSDetails = const DarwinNotificationDetails();
    }

    _flutterLocalNotificationsPlugin.show(id, title, body,
        NotificationDetails(android: androidDetails, iOS: iOSDetails),
        payload: payload);
  }

  static Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showNotification(id, title: title, body: body, payload: payload);
  }

  static Future<String?> getTokenFCM() async {
    if (Platform.isIOS) {
      final token = await messaging.getAPNSToken();
      return token;
    }
    final fcmToken = await messaging.getToken();
    return fcmToken;
  }

  static Future<void> initializeMessageListener(
      InitializationSettings setting) async {
    NotificationIntegration.onListenAndShowNotificationInForeground(setting);
    NotificationIntegration._onListenMessageInBackground();
    NotificationIntegration.setupInteractedMessage();
  }
}
