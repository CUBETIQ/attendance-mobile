import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:timesync360/config/app_config.dart';
import 'package:timesync360/core/network/dio/dio_util.dart';
import 'package:timesync360/core/network/file_upload/model/upload_file_model.dart';
import 'package:timesync360/utils/file_util.dart';

class UploadFileService {
  final dioInstance = DioUtil();

  UploadFileService._();

  static final UploadFileService _instance = UploadFileService._();

  static UploadFileService get instance => _instance;

  Future<UploadFileModel> uploadFile(File file) async {
    try {
      dioInstance.setBaseUrl(AppConfig.uploadUrl);
      final fileName = FileUtil.getFileName(file);
      final contentType =
          lookupMimeType(file.path) ?? 'application/octet-stream';
      final data = FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: MediaType.parse(contentType),
          ),
        },
      );
      final response = await dioInstance.dio.post(
        "/upload",
        data: data,
      );
      if (response.statusCode == 200) {
        return UploadFileModel().fromJson(response.data);
      } else {
        throw Exception("Upload file failed");
      }
    } catch (e) {
      rethrow;
    }
  }
}
