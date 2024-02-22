import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  static const String baseUrl = "http://192.168.1.102:3000/api";

  static String? userAgent;
  static get getUserAgent => userAgent;

  static Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    userAgent =
        "TimeSyncApi:SDK-Dart/${packageInfo.version} (${Platform.isAndroid ? 'Android' : 'iOS'})";
  }
}
