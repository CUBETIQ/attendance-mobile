import 'package:cubetiq_attendance_app/main.dart';
import 'package:cubetiq_attendance_app/data/isar/controller/language_controller.dart';
import 'package:cubetiq_attendance_app/data/isar/controller/storageConfig_controller.dart';
import 'package:cubetiq_attendance_app/data/isar/entities/storageConfig.dart';
import 'package:cubetiq_attendance_app/config/theme/app_theme.dart';
import 'package:cubetiq_attendance_app/config/translation/language_controller.dart';
import 'package:cubetiq_attendance_app/config/translation/translation_model.dart';
import 'package:cubetiq_attendance_app/util/convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingService extends GetxService {
  static SettingService get to => Get.find();
  final StorageServiceImp _appImp = StorageServiceImp();
  final LanguageServiceIsar _lang = LanguageServiceIsar();
  final LanguageController l = Get.find();

  Future<void> initDataBase() async {
    final dbConfig = await _appImp.fetchData();
    storageConfig?.value = dbConfig;
    final dataLanguages = await _lang.fetchData();
    final kh =
        TranslationModel.fromJsonLocal(fromJson(dataLanguages?.kmKH ?? '{}'));
    final en =
        TranslationModel.fromJsonLocal(fromJson(dataLanguages?.enUS ?? '{}'));
    l.langKH.value = kh.getKey;
    l.langEN.value = en.getKey;
    final local = Locale(dbConfig?.language ?? 'en');
    final theme = dbConfig?.darkTheme ?? false;
    isAppOpened = dbConfig?.isAppOpened ?? false;
    Get.updateLocale(local);
    Get.changeTheme(
      theme ? dark : light,
    );
  }

  Future<void> saveLanguageInLocal(String value) async {
    try {
      final data = await _appImp.fetchData();
      final app = StorageConfigure();
      app.id = 1;
      app.language = value;
      // app.isAppOpened = data.isAppOpened;

      await _appImp.insertData(app);
      await Get.updateLocale(Locale(value));
    } catch (e) {
      rethrow;
    }
  }
}
