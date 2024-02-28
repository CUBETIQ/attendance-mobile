import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';

class AppConfig {
  static const String baseUrl = "http://192.168.1.102:3000/api";
  static const String uploadUrl = "https://vfs-server-dev-devx1.ctdn.dev";

  static const String xUploadApiKey = "fb73ce111f0ddde0e56569aa31fc8d30";
  static const String xApiDevice = "TimeSync360";
  static String? xApiHash;

  static const String appName = "TimeSync360";

  static String? _userAgent;
  static get getUserAgent => _userAgent;

  static String? accessToken;

  static bool? isFirstTime = false;

  static bool isDarkMode = false;

  static bool? isActivated = false;

  static bool weWantFatalErrorRecording = true;

  static const double defaultLocationRadius = 200;

  static Future<void> initAppConfig() async {
    final localData = await LocalStorageController.getInstance().get();
    final packageInfo = await PackageInfo.fromPlatform();
    _userAgent =
        "TimeSyncApi:SDK-Dart/${packageInfo.version} (${Platform.isAndroid ? 'Android' : 'iOS'})";
    accessToken = localData?.accessToken;
    isFirstTime = localData?.isFirstTime;
    isActivated = localData?.isActivated;
  }
}
