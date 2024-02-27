import 'package:timesync360/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync360/core/repositories/base_model.dart';

class UploadFileModel extends BaseModel<UploadFileModel> {
  final String? id;
  final String? bucketId;
  final String? fileId;
  final String? extension;
  final String? name;
  final int? size;
  final String? path;
  final String? type;
  final FileMetadata? metadata;
  final String? createdAt;
  final String? url;
  final String? subPath;

  UploadFileModel({
    this.id,
    this.bucketId,
    this.fileId,
    this.extension,
    this.name,
    this.size,
    this.path,
    this.type,
    this.metadata,
    this.createdAt,
    this.url,
    this.subPath,
  });

  @override
  UploadFileModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UploadFileModel();
    }
    return UploadFileModel(
      id: json['id'],
      bucketId: json['bucketId'],
      fileId: json['fileId'],
      extension: json['extension'],
      name: json['name'],
      size: json['size'],
      path: json['path'],
      type: json['type'],
      metadata: FileMetadata().fromJson(json['metadata']),
      createdAt: json['createdAt'],
      url: json['url'],
      subPath: json['subPath'],
    );
  }

  @override
  List<UploadFileModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <UploadFileModel>[];
    }
    return listJson.map((data) => fromJson(data)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bucketId': bucketId,
      'fileId': fileId,
      'extension': extension,
      'name': name,
      'size': size,
      'path': path,
      'type': type,
      'metadata': metadata?.toJson(),
      'createdAt': createdAt,
      'url': url,
      'subPath': subPath,
    };
  }
}
