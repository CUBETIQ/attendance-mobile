import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync360/core/database/isar/entities/local_storage.dart';
import 'package:timesync360/key.dart';
import 'package:timesync360/utils/encrypt_util.dart';

class AppConfig {
  static const String baseUrl = "http://192.168.1.102:3000/api";
  static const String uploadUrl = "https://vfs-server-dev-devx1.ctdn.dev";

  static const String xUploadApiKey = Key.xApiKey;
  static String? xApiHash;

  static const String appName = "TimeSync360";

  // Setup the local storage for fetching while using the app
  static LocalStorage? _localData = LocalStorage();
  static LocalStorage? get getLocalData => _localData;
  static void setConfig(LocalStorage? data) {
    _localData = data;
  }

  static String? _userAgent;
  static get getUserAgent => _userAgent;

  static String? accessToken;

  static bool? isFirstTime = false;

  static bool isDarkMode = false;

  static bool? isActivated = false;

  static bool weWantFatalErrorRecording = true;

  static const double defaultLocationRadius = 200;

  static Future<void> initAppConfig() async {
    _localData = await LocalStorageController.getInstance().get();
    final packageInfo = await PackageInfo.fromPlatform();
    _userAgent =
        "TimeSyncApi:SDK-Dart/${packageInfo.version} (${Platform.isAndroid ? 'Android' : 'iOS'})";
    accessToken = _localData?.accessToken;
    isFirstTime = _localData?.isFirstTime;
    isActivated = _localData?.isActivated;
    xApiHash = EncryptUtil.createHash(Key.xApiKey, Key.publicKey);
  }
}
