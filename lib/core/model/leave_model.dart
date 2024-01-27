import 'package:attendance_app/core/repositories/base_model.dart';

class LeaveModel extends BaseModel<LeaveModel> {
  final String? id;
  final String? userId;
  final String? organizationId;
  final String? departmentId;
  final String? positionId;
  final String? type;
  final String? reason;
  final int? from;
  final int? to;
  final String? status;
  final List<dynamic>? attachment;
  final String? durationType;
  final int? duration;
  final Map<String, dynamic>? updateBy;

  LeaveModel({
    this.id,
    this.userId,
    this.organizationId,
    this.departmentId,
    this.positionId,
    this.type,
    this.reason,
    this.from,
    this.to,
    this.status,
    this.attachment,
    this.durationType,
    this.duration,
    this.updateBy,
  });

  @override
  LeaveModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LeaveModel();
    }
    return LeaveModel(
      id: json['id'],
      userId: json['userId'],
      organizationId: json['organizationId'],
      departmentId: json['departmentId'],
      positionId: json['positionId'],
      type: json['type'],
      reason: json['reason'],
      from: json['from'],
      to: json['to'],
      status: json['status'],
      attachment: json['attachment'],
      durationType: json['durationType'],
      duration: json['duration'],
      updateBy: json['updateBy'],
    );
  }

  @override
  List<LeaveModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <LeaveModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'organizationId': organizationId,
      'departmentId': departmentId,
      'positionId': positionId,
      'type': type,
      'reason': reason,
      'from': from,
      'to': to,
      'status': status,
      'attachment': attachment,
      'durationType': durationType,
      'duration': duration,
      'updateBy': updateBy,
    };
  }
}

class UpdateByModel extends BaseModel<UpdateByModel> {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? image;

  UpdateByModel({
    this.firstName,
    this.lastName,
    this.username,
    this.image,
  });

  @override
  UpdateByModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UpdateByModel();
    }
    return UpdateByModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      image: json['image'],
    );
  }

  @override
  List<UpdateByModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <UpdateByModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'image': image,
    };
  }
}
