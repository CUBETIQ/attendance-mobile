import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class FileUtil {
  static String getFileName(File file) {
    return file.path.split('/').last;
  }

  static FormData getFormData(File file) {
    final fileName = getFileName(file);
    final contentType = lookupMimeType(file.path) ?? 'application/octet-stream';

    return FormData.fromMap(
      {
        "file": MultipartFile.fromFileSync(
          file.path,
          filename: fileName,
          contentType: MediaType.parse(contentType),
        ),
      },
    );
  }
}
