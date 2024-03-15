import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:timesync/app.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/database/local_path/app_path_controller.dart';
import 'package:timesync/notification/notification_service.dart';
import 'package:timesync/utils/logger.dart';

// using SizeUits.scale for make the bigger device and smalller device have same Ui size we need for mobile

// using SizeUits.scaleTablet for make the bigger device and smalller device have same Ui size we need

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // initialize the app config
  await AppConfig.initAppConfig();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase App and Messaging
  await firebaseInit();

  await initService();
  await AppPathController.initPath();

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

Future<void> initService() async {
  await IsarService().initDataBase();
}

Future<void> firebaseInit() async {
  Logs.t('[firebaseInitialized] Initializing Firebase');
  // Initialize Firebase App and Messaging
  await Firebase.initializeApp();
  NotificationIntegration.initializeNotificationBackground();
  await NotificationIntegration.requestSettings();

  //////////// Firebase Crashlytics ////////////
  FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(kDebugMode ? false : true);

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    if (AppConfig.weWantFatalErrorRecording) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    } else {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: AppConfig.weWantFatalErrorRecording,
    );
    return true;
  };
  //////////// Firebase Crashlytics ////////////
}
