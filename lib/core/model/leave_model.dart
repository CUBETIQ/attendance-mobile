import 'package:attendance_app/core/repositories/base_model.dart';

class LeaveModel extends BaseModel<LeaveModel> {
  final String? id;
  final String? userId;
  final String? organizationId;
  final String? departmentId;
  final String? positionId;
  final String? leaveType;
  final String? leaveReason;
  final int? leaveFrom;
  final int? leaveTo;
  final String? leaveStatus;
  final List<String>? leaveAttachment;
  final String? leaveDurationType;
  final int? leaveDuration;
  final String? updateBy;

  LeaveModel({
    this.id,
    this.userId,
    this.organizationId,
    this.departmentId,
    this.positionId,
    this.leaveType,
    this.leaveReason,
    this.leaveFrom,
    this.leaveTo,
    this.leaveStatus,
    this.leaveAttachment,
    this.leaveDurationType,
    this.leaveDuration,
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
      leaveType: json['leaveType'],
      leaveReason: json['leaveReason'],
      leaveFrom: json['leaveFrom'],
      leaveTo: json['leaveTo'],
      leaveStatus: json['leaveStatus'],
      leaveAttachment: json['leaveAttachment'],
      leaveDurationType: json['leaveDurationType'],
      leaveDuration: json['leaveDuration'],
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
      'leaveType': leaveType,
      'leaveReason': leaveReason,
      'leaveFrom': leaveFrom,
      'leaveTo': leaveTo,
      'leaveStatus': leaveStatus,
      'leaveAttachment': leaveAttachment,
      'leaveDurationType': leaveDurationType,
      'leaveDuration': leaveDuration,
      'updateBy': updateBy,
    };
  }
}
