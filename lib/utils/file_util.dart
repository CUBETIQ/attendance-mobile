import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:timesync360/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync360/utils/logger.dart';

class FileUtil {
  static const maxFileSize = 5 * 1024 * 1024; // 5MB in bytes
  static const maxProfileSize = 2 * 1024 * 1024; // 2MB in bytes

  static String getFileName(File file) {
    return file.path.split('/').last;
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
}
