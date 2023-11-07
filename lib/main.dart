import 'package:cubetiq_attendance_app/app.dart';
import 'package:cubetiq_attendance_app/data/isar/entities/storageConfig.dart';
import 'package:cubetiq_attendance_app/data/isar/services/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

bool isAppOpened = false;
Rx<StorageConfigure?>? storageConfig = Rx<StorageConfigure?>(null);

Future<void> main() async {
  await initDBService();
  runApp(const MyApp());
}

Future<void> initDBService() async {
  await SettingService().initDataBase();
}
