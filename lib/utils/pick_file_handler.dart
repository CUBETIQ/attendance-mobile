import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timesync360/utils/file_util.dart';
import 'package:timesync360/utils/permission_handler.dart';

class PickFileHandler {
  static Future<File?> openGallery() async {
    File? file;
    final permission = Platform.isIOS
        ? await PermissonHandler.requestPhotoPermission()
        : await PermissonHandler.requestStoragePermission();
    if (permission) {
      try {
        final result =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (result != null) {
          file = File(result.path);
          final validateFileSize = await FileUtil.validateFileSize(file);
          if (validateFileSize) {
            return file;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } catch (e) {
        rethrow;
      }
    } else {
      return null;
    }
  }

  static Future<File?> openCamera() async {
    File? file;
    final permission = await PermissonHandler.requestCameraPermission();
    if (permission) {
      try {
        final result =
            await ImagePicker().pickImage(source: ImageSource.camera);
        if (result != null) {
          file = File(result.path);
          final validateFileSize = await FileUtil.validateFileSize(file);
          if (validateFileSize) {
            return file;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } catch (e) {
        rethrow;
      }
    } else {
      return null;
    }
  }

  static Future<File?> openFileFolder() async {
    File? file;
    final permission = await PermissonHandler.requestStoragePermission();
    if (permission) {
      try {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
        );
        if (result != null) {
          file = File(result.files.single.path!);
          final validateFileSize = await FileUtil.validateFileSize(file);
          if (validateFileSize) {
            return file;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } catch (e) {
        rethrow;
      }
    } else {
      return null;
    }
  }
}
