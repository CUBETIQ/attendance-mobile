import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timesync/utils/image_cropper.dart';
import 'package:timesync/utils/permission_handler.dart';

class PickFileHandler {
  static Future<File?> openGallery() async {
    File? file;
    final permission =
        Platform.isIOS ? await PermissonHandler.requestPhotoPermission() : true;
    if (permission) {
      try {
        final result =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (result != null) {
          CroppedFile? croppedFile =
              await MyImageCropper.cropImage(sourcePath: result.path);
          if (croppedFile == null) {
            return null;
          }

          file = await compressedFile(File(croppedFile.path));

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
          CroppedFile? croppedFile =
              await MyImageCropper.cropImage(sourcePath: result.path);
          if (croppedFile == null) {
            return null;
          }

          file = await compressedFile(File(croppedFile.path));

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

  static Future<File> compressedFile(File file) async {
    int imgCompressedQuality = 90;
    Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
      file.path,
      quality: imgCompressedQuality,
    );
    await file.writeAsBytes(compressedBytes!.cast<int>());

    return file;
  }
}
