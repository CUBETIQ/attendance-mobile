import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/core/database/isar/entities/local_storage.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/theme/theme_data.dart';
import 'package:get/get.dart';

class IsarService extends GetxService {
  static IsarService get to => Get.find();
  final LocalStorageController _localStorage = LocalStorageController();

  Future<void> initDataBase() async {
    final appConfig = await _localStorage.get();
    storageConfig?.value = appConfig;
    isFirstTime = appConfig?.isFirstTime ?? false;
    Get.changeTheme(
        appConfig?.darkTheme ?? false ? darkThemeData() : lightThemeData());
  }

  Future<void> clearDataBase() async {
    await _localStorage.clear();
  }

  Future<void> saveLocalData({
    bool? isFirstTime,
    String? accessToken,
    bool? darkTheme,
    String? language,
    bool? isRememberMe,
    String? username,
    String? refreshToken,
    bool? isActivated,
    String? organizationId,
  }) async {
    try {
      final appConfig = await _localStorage.get();
      final app = LocalStorage();
      app.id = 1;
      app.isActivated = isActivated ?? appConfig?.isActivated;
      app.isFirstTime = isFirstTime ?? appConfig?.isFirstTime;
      app.accessToken = accessToken ?? appConfig?.accessToken;
      app.refreshToken = refreshToken ?? appConfig?.refreshToken;
      app.darkTheme = darkTheme ?? appConfig?.darkTheme;
      app.language = language ?? appConfig?.language;
      app.isRememberMe = isRememberMe ?? appConfig?.isRememberMe;
      app.username = username ?? appConfig?.username;
      app.organizationId = organizationId ?? appConfig?.organizationId;
      await _localStorage.insert(app);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalData({bool? deleteToken, bool? unactivate}) async {
    try {
      final appConfig = await _localStorage.get();
      final app = LocalStorage();
      app.id = 1;
      app.isActivated = unactivate == true ? null : appConfig?.isActivated;
      app.isFirstTime = appConfig?.isFirstTime;
      app.accessToken = deleteToken == true ? null : appConfig?.accessToken;
      app.refreshToken = deleteToken == true ? null : appConfig?.refreshToken;
      app.organizationId = appConfig?.organizationId;
      app.darkTheme = appConfig?.darkTheme;
      app.language = appConfig?.language;
      app.isRememberMe = appConfig?.isRememberMe;
      app.username = appConfig?.username;
      await _localStorage.insert(app);
    } catch (e) {
      rethrow;
    }
  }
}
