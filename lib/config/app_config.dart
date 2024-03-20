import 'dart:io';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timesync/app_version.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/entities/local_storage.dart';
import 'package:timesync/config/key.dart';
import 'package:timesync/utils/encrypt_util.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class AppConfig {
  // DEV
  static const String baseUrl = "http://192.168.1.104:3000/api";
  static const String uploadUrl = "https://vfs-server-dev-devx1.ctdn.dev";

  // PROD - UAT
  // static const String baseUrl = "https://timesync-api-uat.ctdn.dev/api";
  // static const String uploadUrl =
  //     "https://timesync-usercontent-prod.cubetiq.app";

  // FIREBASE
  static const String appName = "Timesync 365";

  static const String xUploadApiKey = Key.vfsClientApiKey;

  static String? xApiHash;

  static String? appLocalPath;

  static int delayTimeInMinute = 3;

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

  static final isDevMode = false.obs;

  static final confirmCheckIn = (_localData?.confirmCheckIn ?? true).obs;

  static String? theme;

  static bool? isActivated = false;

  static bool weWantFatalErrorRecording = true;

  static const double defaultLocationRadius = 200;

  static PackageInfo? packageInfo;

  static Future<void> initAppConfig() async {
    // init timezone
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    _localData = await LocalStorageController.getInstance().get();
    packageInfo = await PackageInfo.fromPlatform();
    _userAgent =
        "TimeSyncApi:SDK-Dart/${packageInfo?.version}-${AppVersion.version} (${Platform.isAndroid ? 'Android' : 'iOS'})";
    accessToken = _localData?.accessToken;
    isFirstTime = _localData?.isFirstTime;
    isActivated = _localData?.isActivated;
    appLocalPath = await FileUtil.getLocalPath();
    xApiHash =
        EncryptUtil.createHash(Key.vfsClientApiKey, Key.vfsClientPublicKey);
  }
}
