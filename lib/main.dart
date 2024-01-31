import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:timesync360/app.dart';
import 'package:timesync360/core/database/isar/entities/local_storage.dart';
import 'package:timesync360/core/database/isar/service/isar_service.dart';
import 'package:timesync360/core/database/local_path/app_path_controller.dart';

// using SizeUits.scaleWidth for make the bigger device and smalller device have same Ui size we need

bool isFirstTime = false;
bool isDarkMode = false;
Rx<LocalStorage?>? storageConfig = Rx<LocalStorage?>(null);

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initService();
  await AppPathController.initPath();
  const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

Future<void> initService() async {
  await IsarService().initDataBase();
}
