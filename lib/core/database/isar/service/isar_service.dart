import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/main.dart';
import 'package:get/get.dart';

class IsarService extends GetxService {
  static IsarService get to => Get.find();
  final LocalStorageController _localStorage = LocalStorageController();

  Future<void> initDataBase() async {
    final appConfig = await _localStorage.get();
    storageConfig?.value = appConfig;
    isFirstTime = appConfig?.isFirstTime ?? false;
  }
}
