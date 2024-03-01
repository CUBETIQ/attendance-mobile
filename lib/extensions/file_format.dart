import 'dart:io';

import 'package:mime/mime.dart';

extension FileFormat on File {
  String get formatFileSize {
    final bytes = lengthSync();
    if (bytes < 1024) {
      return '${bytes}B';
    } else if (bytes < 1024 * 1024) {
      double kilobytes = bytes / 1024;
      return '${kilobytes.toStringAsFixed(2)}KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      double megabytes = bytes / (1024 * 1024);
      return '${megabytes.toStringAsFixed(2)}MB';
    } else {
      double gigabytes = bytes / (1024 * 1024 * 1024);
      return '${gigabytes.toStringAsFixed(2)}GB';
    }
  }

  bool get isImage {
    String? mimeType = lookupMimeType(path);
    return mimeType == 'image/png' || mimeType == 'image/jpeg';
  }
}