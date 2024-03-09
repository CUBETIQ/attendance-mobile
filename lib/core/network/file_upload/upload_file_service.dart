import 'dart:io';
import 'package:dio/dio.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync/core/network/file_upload/model/upload_file_model.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timesync/utils/logger.dart';

class UploadFileService {
  static final _singleton = UploadFileService._internal();
  final dioInstance = DioUtil();

  factory UploadFileService() {
    return _singleton;
  }

  UploadFileService._internal() {
    Logs.t('[UploadFileService] Initialized');
  }

  Future<UploadFileModel?> uploadFile(File file, FileMetadata? metadata) async {
    try {
      dioInstance.setBaseUrl(AppConfig.uploadUrl);
      dioInstance.addHeader({
        "x-api-key": AppConfig.xUploadApiKey,
        // "x-api-hash": AppConfig.xApiHash,
      });

      final data = FileUtil.getFormData(file, metadata);
      final response = await dioInstance.dio.post(
        "/api/upload",
        data: data,
      );
      if (response.statusCode == 200) {
        return UploadFileModel().fromJson(response.data);
      } else {
        throw Exception("Upload file failed");
      }
    } on DioException catch (e) {
      Logs.e(e.message);
    } finally {
      dioInstance.setBaseUrl(AppConfig.baseUrl);
    }
    return null;
  }
}
