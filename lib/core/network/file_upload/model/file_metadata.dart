import 'package:timesync360/core/repositories/base_model.dart';

class FileMetadata extends BaseModel<FileMetadata> {
  final String? userId;
  final String? source;

  FileMetadata({this.userId, this.source});

  @override
  FileMetadata fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return FileMetadata();
    }
    return FileMetadata(
      userId: json['userId'],
      source: json['source'],
    );
  }

  @override
  List<FileMetadata> fromListJson(List? listJson) {
    if (listJson == null) {
      return <FileMetadata>[];
    }
    return listJson.map((data) => fromJson(data)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'source': source,
    };
  }
}
