import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:timesync360/utils/permission_handler.dart';

class PickFileHandler {
  static Future<File?> openGallery() async {
    File? file;
    final permission = await PermissonHandler.requestStoragePermission();
    if (permission) {
      try {
        final result =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (result != null) {
          file = File(result.path);
          return file;
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
          return file;
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
