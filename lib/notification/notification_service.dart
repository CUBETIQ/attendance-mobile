import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timesync360/config/app_config.dart';
import 'package:timesync360/firebase_options.dart';
import 'package:timesync360/utils/logger.dart';

class NotificationService {
  /////// Singleton ////////
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  static Future<void> initializeFirebase() async {
    if (Firebase.apps.isNotEmpty) {
      Logs.w('Firebase has been initialized');
      return;
    }

    await Firebase.initializeApp(
      name: AppConfig.appName,
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await setupInteractedMessage();
  }

  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background, when the app is opened from a terminated state
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    Logs.i('FirebaseMessaging setupInteractedMessage has been set');
  }

  static void _handleMessage(RemoteMessage message) {
    Logs.i('[_handleMessage] Handling a remote message: ${message.toMap()}');
  }

  // NOTICE: This service handler the background notification
  static void initializeFirebaseMessagingBackgroundHandler() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    Logs.i('FirebaseMessaging background handler has been set');
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await initializeFirebase();

    Logs.i("Handling a background message: ${message.toMap()}");
  }
}
