import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/notification/notification_topic.dart';
import 'package:timesync/utils/logger.dart';

class StorageManagementController extends GetxController {
  static StorageManagementController get to => Get.find();
  final localCache = ''.obs;
  final userData = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCache();
    calculateLocalStorageSize();
  }

  ///Format file size
  _renderSize(double value) {
    if (value == 0) {
      return '0 Kb';
    }
    List<String> unitArr = ['Byte', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + (index == 0 ? ' ${unitArr[index]}' : unitArr[index]);
  }

  //Get Cache
  Future<void> loadCache() async {
    try {
      Directory tempDir = await getApplicationSupportDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      localCache.value = _renderSize(value);
    } catch (err) {
      Logs.e('Error while loading cache', error: err);
    }
  }

  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        for (final FileSystemEntity child in children) {
          total += await _getTotalSizeOfFilesInDir(child);
        }
        return total;
      }
      return 0;
    } catch (e) {
      Logs.e('Error while getting size of files', error: e);
      return 0;
    }
  }

  //Clear Cache
  Future<void> onTapClearCached() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      await delDir(tempDir);
      await loadCache();
      await calculateLocalStorageSize();
      showSuccessSnackBar('Success', 'You have cleared cache successfully');
    } catch (e) {
      Logs.e('Error while clearing cache', error: e);
      showErrorSnackBar('Error', 'You have failed to clear the cache');
    } finally {
      //Hidden here loading loading
    }
  }

  Future<void> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      Logs.e('Error while deleting directory', error: e);
    }
  }
  //================================

  //User Data Storage
  Future<void> calculateLocalStorageSize() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    int totalSizeBytes = await _calculateDirectorySize(appDocDir);

    // double totalSizeMB = totalSizeBytes / (1024 * 1024);

    userData.value = _renderSize(totalSizeBytes.toDouble());
  }

  Future<int> _calculateDirectorySize(Directory directory) async {
    int size = 0;

    if (directory.existsSync()) {
      List<FileSystemEntity> entities = directory.listSync(recursive: true);
      for (FileSystemEntity entity in entities) {
        if (entity is File) {
          size += await entity.length();
        }
      }
    }

    return size;
  }

  //Clear User Data
  Future<void> onTapClearUserData() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    await _deleteDirectoryContents(appDocDir);
    await loadCache();
    await calculateLocalStorageSize();
    showSuccessSnackBar(
        'Success', 'You have successfully cleared the user data');
  }

  Future<void> _deleteDirectoryContents(Directory directory) async {
    if (directory.existsSync()) {
      List<FileSystemEntity> entities = directory.listSync();
      for (FileSystemEntity entity in entities) {
        if (entity is File) {
          await entity.delete();
        } else if (entity is Directory) {
          await _deleteDirectoryContents(entity);
          await entity.delete();
        }
      }
    }
  }
  //================================

  Future<void> onTapResetApp() async {
    await onTapClearUserData();
    await onTapClearCached();
    await IsarService().clearDataBase();

    NotificationTopic.unsubscribeAll();
    showSuccessSnackBar('Success', 'You have successfully reset the app');
    Restart.restartApp();
  }
}
