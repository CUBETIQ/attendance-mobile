import 'package:attendance_app/core/repositories/base_model.dart';

class UserStatusModel extends BaseModel<UserStatusModel> {
  final String? id;
  final String? userId;
  final String? status;
  final int? lastUpdatedAt;
  UserStatusModel({
    this.id,
    this.userId,
    this.status,
    this.lastUpdatedAt,
  });

  @override
  UserStatusModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UserStatusModel();
    }

    return UserStatusModel(
      id: json['id'],
      userId: json['userId'],
      status: json['status'],
      lastUpdatedAt: json['lastUpdatedAt'],
    );
  }

  @override
  List<UserStatusModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <UserStatusModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'lastUpdatedAt': lastUpdatedAt,
    };
  }
}
