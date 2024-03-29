import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/repositories/base_model.dart';
import 'package:timesync/extensions/string.dart';

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
  final String? durationType;
  final double? duration;
  final UpdateByModel? updateBy;
  final List<AttachmentModel>? attachment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
    this.createdAt,
    this.updatedAt,
  });

  @override
  LeaveModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LeaveModel();
    }
    double? durations;
    if (json["duration"] is int) {
      durations = json["duration"].toString().toDouble();
    } else {
      durations = json["duration"];
    }

    final createdDate =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    final updatedDate =
        json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;

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
      durationType: json['durationType'],
      duration: durations,
      createdAt: createdDate,
      updatedAt: updatedDate,
      updateBy: UpdateByModel().fromJson(json['updateBy']),
      attachment: AttachmentModel().fromListJson(json['attachment']),
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
