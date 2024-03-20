import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timesync/utils/permission_handler.dart';

class PickFileHandler {
  static int imgCompressedQuality = 90;

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

          Uint8List? compressedBytes =
              await FlutterImageCompress.compressWithFile(
            file.path,
            quality: imgCompressedQuality,
          );
          await file.writeAsBytes(compressedBytes!.cast<int>());

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

          Uint8List? compressedBytes =
              await FlutterImageCompress.compressWithFile(
            file.path,
            quality: imgCompressedQuality,
          );
          await file.writeAsBytes(compressedBytes!.cast<int>());

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
