import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';

class AppConfig {
  static const String baseUrl = "http://192.168.1.102:3000/api";

  static String? userAgent;
  static get getUserAgent => userAgent;

  static String? accessToken;
  static get getAccessToken => accessToken;

  static bool? isFirstTime;
  static get getIsFirstTime => isFirstTime;

  static bool? isActivated;
  static get getIsActivated => isActivated;

  static Future<void> initAppConfig() async {
    final localData = await LocalStorageController.getInstance().get();
    final packageInfo = await PackageInfo.fromPlatform();
    userAgent =
        "TimeSyncApi:SDK-Dart/${packageInfo.version} (${Platform.isAndroid ? 'Android' : 'iOS'})";
    accessToken = localData?.accessToken;
    isFirstTime = localData?.isFirstTime;
    isActivated = localData?.isActivated;
  }
}
