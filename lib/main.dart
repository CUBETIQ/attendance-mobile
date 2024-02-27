import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:timesync360/app.dart';
import 'package:timesync360/config/app_config.dart';
import 'package:timesync360/core/database/isar/service/isar_service.dart';
import 'package:timesync360/core/database/local_path/app_path_controller.dart';
import 'package:timesync360/firebase_options.dart';

// using SizeUits.scaleWidth for make the bigger device and smalller device have same Ui size we need

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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

  await initService();
  await AppPathController.initPath();

  // initialize the app config
  await AppConfig.initAppConfig();

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

Future<void> initService() async {
  await IsarService().initDataBase();
}
