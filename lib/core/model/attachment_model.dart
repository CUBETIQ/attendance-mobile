import 'dart:io';
import 'package:timesync/core/repositories/base_model.dart';

class AttachmentModel extends BaseModel<AttachmentModel> {
  final String? id;
  final String? fileId;
  final String? name;
  final String? extension;
  final String? url;
  final int? size;
  final int? date;
  File? file;

  AttachmentModel({
    this.id,
    this.fileId,
    this.name,
    this.extension,
    this.url,
    this.file,
    this.date,
    this.size,
  });

  @override
  AttachmentModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AttachmentModel();
    }
    return AttachmentModel(
      id: json['id'],
      fileId: json['file_id'],
      name: json['name'],
      extension: json['extension'],
      url: json['url'],
      size: json['size'],
      date: json['date'],
    );
  }

  @override
  List<AttachmentModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return [];
    }
    return listJson.map((json) => fromJson(json)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_id': fileId,
      'name': name,
      'extension': extension,
      'url': url,
      'size': size,
      'date': date,
    };
  }
}
