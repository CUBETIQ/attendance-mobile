import 'package:attendance_app/app.dart';
import 'package:attendance_app/core/database/isar/entities/local_storage.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/database/local_path/app_path_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

// using SizeUits.scaleWidth for make the bigger device and smalller device have same Ui size we need

bool isFirstTime = false;
Rx<LocalStorage?>? storageConfig = Rx<LocalStorage?>(null);

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initDBService();
  await AppPathController.initPath();
  const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent);
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.manual,
  //   overlays: [SystemUiOverlay.top],
  // );
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

Future<void> initDBService() async {
  await IsarService().initDataBase();
}
