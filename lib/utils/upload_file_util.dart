import 'package:timesync360/core/model/attachment_model.dart';
import 'package:timesync360/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync360/core/network/file_upload/upload_file_service.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/utils/file_util.dart';

class UploadFileUtil {
  static Future<List<AttachmentModel>> uploadFiles(
      List<AttachmentModel> attachments, String source) async {
    final metedata = FileMetadata(
      source: source,
      userId: NavigationController.to.user.value.id,
    );
    try {
      final data = await Future.wait<AttachmentModel>(
        attachments.map((attachment) async {
          if (attachment.file != null) {
            final data = await UploadFileService().uploadFile(
              attachment.file!,
              metedata,
            );
            final checkFileExistInLocalStorage = FileUtil.checkFileExist(
              fileName: FileUtil.getFileName(attachment.file),
            );
            if (!checkFileExistInLocalStorage) {
              await FileUtil.saveFileToLocalStorage(
                fileName: FileUtil.getFileName(attachment.file),
                filePath: attachment.file?.path ?? "",
              );
            }
            return AttachmentModel(
              id: data?.id,
              fileId: data?.fileId,
              name: data?.name,
              url: data?.url,
              date: DateTime.now().millisecondsSinceEpoch,
              size: data?.size,
              extension: data?.extension,
            );
          } else {
            return attachment;
          }
        }),
      );
      data.removeWhere((element) => element.id == null);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
