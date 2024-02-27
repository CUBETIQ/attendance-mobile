import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:timesync360/core/network/file_upload/model/file_metadata.dart';

class FileUtil {
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
}
