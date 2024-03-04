import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timesync360/config/app_config.dart';
import 'package:timesync360/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync360/utils/logger.dart';
import 'package:timesync360/utils/permission_handler.dart';

class FileUtil {
  static const maxFileSize = 5 * 1024 * 1024; // 5MB in bytes
  static const maxProfileSize = 2 * 1024 * 1024; // 2MB in bytes

  static String getFileName(File file) {
    return file.path.split('/').last;
  }

  static bool checkFileImageExtension(String? extension) {
    if (extension == null) return false;

    if (extension == '.jpg' ||
        extension == '.jpeg' ||
        extension == '.png' ||
        extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png') {
      return true;
    }
    return false;
  }

  static FormData getFormData(File file, FileMetadata? metadata) {
    final fileName = getFileName(file);
    final contentType = lookupMimeType(file.path) ?? 'application/octet-stream';
    return FormData.fromMap(
      {
        'metadata': metadata?.toJson(),
        'bucket_id': 'timesync360',
        "file": MultipartFile.fromFileSync(
          file.path,
          filename: fileName,
          contentType: MediaType.parse(contentType),
        ),
      },
    );
  }

  static Future<bool> validateFileSize(File file) async {
    final fileSize = await file.length();
    if (fileSize > maxFileSize) {
      Logs.e("File cannot be larger than 5MB");
      return false;
    }
    return true;
  }

  static Future<bool> validateProfileSize(File file) async {
    final fileSize = await file.length();
    if (fileSize > maxProfileSize) {
      Logs.e("Profile cannot be larger than 2MB");
      return false;
    }
    return true;
  }

  static String getFileSize(File file) {
    final fileSize = file.lengthSync();
    final kb = fileSize / 1024;
    final mb = kb / 1024;
    if (mb > 1) {
      return "${mb.toStringAsFixed(2)} MB";
    } else if (kb > 1) {
      return "${kb.toStringAsFixed(2)} KB";
    } else {
      return "${fileSize.toStringAsFixed(2)} B";
    }
  }

  // get timesync local file path if there is none it will create new folder
  static Future<String> getLocalPath() async {
    String? localPath;
    try {
      if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        localPath = directory.path;
      } else {
        final externalPath = await getExternalStorageDirectory();
        final directory = Directory('${externalPath?.path}');

        if (await directory.exists()) {
          localPath = directory.path;
          return localPath;
        } else {
          final newDirectory = await directory.create(recursive: true);
          localPath = newDirectory.path;
          return localPath;
        }
      }
    } catch (err) {
      Logs.e("Error: $err");
    }
    return localPath ?? "";
  }

  static Future<void> openFile(String fileName) async {
    final checkStoragePermission =
        await PermissonHandler.requestStoragePermission();
    if (checkStoragePermission) {
      var filePath = '${AppConfig.appLocalPath}/${basename(fileName)}';
      OpenFile.open(filePath);
    }
  }

  static bool checkFileExist({
    required String? fileName,
  }) {
    var filePath = '${AppConfig.appLocalPath}/${basename(fileName!)}';
    bool fileExistsCheck = File(filePath).existsSync();
    return fileExistsCheck;
  }

  static Future<void> downloadFile(String filename, String url, double progress,
      {void Function(bool)? checkDownloading}) async {
    try {
      bool isDownloading = false;
      final dio = Dio();
      await dio.download(
        url,
        "${AppConfig.appLocalPath}/$filename",
        options: Options(
          headers: {HttpHeaders.acceptEncodingHeader: "*"},
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
        onReceiveProgress: (count, total) {
          double progressValue = (count / total) * 100;
          progress = progressValue;
          isDownloading = true;
          checkDownloading?.call(isDownloading);
          if (progressValue >= 100) {
            isDownloading = false;
            checkDownloading?.call(isDownloading);
          } else if (progressValue.isNegative) {
            isDownloading = false;
            checkDownloading?.call(isDownloading);
          }
        },
      );
    } catch (e) {
      Logs.e("Error: $e");
    }
  }
}
