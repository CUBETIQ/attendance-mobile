import 'package:timesync360/core/database/isar/controller/local_language_controller.dart';
import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync360/core/database/isar/entities/language.dart';
import 'package:timesync360/core/database/isar/entities/local_storage.dart';
import 'package:timesync360/core/database/isar/model/lcoal_storage_model.dart';
import 'package:timesync360/main.dart';
import 'package:get/get.dart';
import 'package:timesync360/utils/logger.dart';

class IsarService extends GetxService {
  static IsarService get to => Get.find();
  final LocalStorageController _localStorage =
      LocalStorageController.getInstance();
  final LanguageLocalStorageController _languageLocalStorage =
      LanguageLocalStorageController.getInstance();

  Future<void> initDataBase() async {
    final appConfig = await _localStorage.get();
    if (appConfig == null) {
      final app = LocalStorage();
      app.id = 1;
      app.isActivated = false;
      app.isFirstTime = true;
      app.darkTheme = false;
      app.language = 'en';
      app.isRememberMe = false;
      await _localStorage.insert(app);
    }
    storageConfig?.value = appConfig;
    isFirstTime = appConfig?.isFirstTime ?? false;
    isDarkMode = appConfig?.darkTheme ?? false;
  }

  Future<void> clearDataBase() async {
    await _localStorage.clear();
    await _languageLocalStorage.clear();
  }

  Future<void> saveLocalData({LocalStorageModel? input}) async {
    try {
      final appConfig = await _localStorage.get();
      if (appConfig == null) {
        return;
      }
      Logs.i(input?.isFirstTime);
      appConfig.isActivated = input?.isActivated ?? appConfig.isActivated;
      appConfig.isFirstTime = input?.isFirstTime ?? appConfig.isFirstTime;
      appConfig.accessToken = input?.accessToken ?? appConfig.accessToken;
      appConfig.refreshToken = input?.refreshToken ?? appConfig.refreshToken;
      appConfig.darkTheme = input?.darkTheme ?? appConfig.darkTheme;
      appConfig.language = input?.language ?? appConfig.language;
      appConfig.isRememberMe = input?.isRememberMe ?? appConfig.isRememberMe;
      appConfig.username = input?.username ?? appConfig.username;
      appConfig.organizationId =
          input?.organizationId ?? appConfig.organizationId;
      await _localStorage.insert(appConfig);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveLanguage({String? kmLang, String? enLang}) async {
    try {
      final appConfig = await _languageLocalStorage.get();
      final app = Languages();
      app.id = 1;
      app.enUS = enLang ?? appConfig?.enUS;
      app.kmKH = kmLang ?? appConfig?.kmKH;
      await _languageLocalStorage.insert(app);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalData({bool? deleteToken, bool? unactivate}) async {
    try {
      final appConfig = await _localStorage.get();
      if (appConfig == null) {
        return;
      }
      appConfig.id = 1;
      appConfig.isActivated = unactivate == true ? null : appConfig.isActivated;
      appConfig.isFirstTime = appConfig.isFirstTime;
      appConfig.accessToken =
          deleteToken == true ? null : appConfig.accessToken;
      appConfig.refreshToken =
          deleteToken == true ? null : appConfig.refreshToken;
      appConfig.organizationId = appConfig.organizationId;
      appConfig.darkTheme = appConfig.darkTheme;
      appConfig.language = appConfig.language;
      appConfig.isRememberMe = appConfig.isRememberMe;
      appConfig.username = appConfig.username;
      await _localStorage.insert(appConfig);
    } catch (e) {
      rethrow;
    }
  }
}
