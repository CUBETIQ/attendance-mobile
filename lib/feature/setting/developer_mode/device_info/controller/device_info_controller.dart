import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/notification/notification_service.dart';

class DeviceInfoController extends GetxController {
  static DeviceInfoController get to => Get.find();

  final deviceInfo = Rx<Map<String, dynamic>>({});
  final deviceInfoPlugin = DeviceInfoPlugin();
  String? fcmToken;
  final screenSize = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single);

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  Future<void> getInfo() async {
    fcmToken = await NotificationIntegration.messaging.getToken();
    deviceInfo.value = await fetchDeviceInfo();
  }

  Future<Map<String, dynamic>> fetchDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        final info = await deviceInfoPlugin.androidInfo;
        return deviceInfo.value = _readAndroidBuildData(info);
      } else if (Platform.isIOS) {
        final info = await deviceInfoPlugin.iosInfo;
        return deviceInfo.value = _readIosDeviceInfo(info);
      } else {
        throw UnimplementedError();
      }
    } on PlatformException {
      return <String, dynamic>{'Error:': 'Failed to get getInfo'};
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo info) =>
      <String, dynamic>{
        'phone': "${info.manufacturer} ${info.model}",
        'device': info.device,
        'brand': info.brand,
        'screen resolution':
            '${screenSize.size.width} x ${screenSize.size.height}',
        'isPhysicalDevice': info.isPhysicalDevice,
        'manufacturer': info.manufacturer,
        'userId': AppConfig.getLocalData?.userId,
        'fcmtoken': fcmToken,
        '': '',
        ' ': '',
        'identifierForVendor': info.id,
        'type': info.type,
        'version.sdkInt': info.version.sdkInt,
        'version.securityPatch': info.version.securityPatch,
        'version.release': info.version.release,
        'version.previewSdkInt': info.version.previewSdkInt,
        'version.incremental': info.version.incremental,
        'version.codename': info.version.codename,
        'version.baseOS': info.version.baseOS,
        'board': info.board,
        'bootloader': info.bootloader,
        'display': info.display,
        'fingerprint': info.fingerprint,
        'hardware': info.hardware,
        'host': info.host,
        'id': info.id,
        'product': info.product,
        'supported32BitAbis': info.supported32BitAbis,
        'supported64BitAbis': info.supported64BitAbis,
        'supportedAbis': info.supportedAbis,
        'tags': info.tags,
      };

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) =>
      <String, dynamic>{
        'name': info.name,
        'systemName': info.systemName,
        'systemVersion': info.systemVersion,
        'model': info.model,
        'localizedModel': info.localizedModel,
        'identifierForVendor': info.identifierForVendor,
        'isPhysicalDevice': info.isPhysicalDevice,
        'utsname.sysname:': info.utsname.sysname,
        'utsname.nodename:': info.utsname.nodename,
        'utsname.release:': info.utsname.release,
        'utsname.version:': info.utsname.version,
        'utsname.machine:': info.utsname.machine,
        'fcmtoken': fcmToken,
        'userId': AppConfig.getLocalData?.userId,
        '': '',
        ' ': '',
      };
}
