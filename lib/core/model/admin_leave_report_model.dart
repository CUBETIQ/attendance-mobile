import 'package:timesync360/core/repositories/base_model.dart';

class AdminLeaveReportModel extends BaseModel<AdminLeaveReportModel> {
  final String? username;
  final String? organizationId;
  final String? role;
  final String? name;
  final String? gender;
  final String? firstName;
  final String? lastName;
  final String? image;
  final LeaveReportModel? leave;

  AdminLeaveReportModel({
    this.username,
    this.organizationId,
    this.role,
    this.name,
    this.gender,
    this.firstName,
    this.lastName,
    this.image,
    this.leave,
  });

  @override
  AdminLeaveReportModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AdminLeaveReportModel();
    }
    return AdminLeaveReportModel(
      username: json['username'],
      organizationId: json['organizationId'],
      role: json['role'],
      name: json['name'],
      gender: json['gender'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
      leave: LeaveReportModel().fromJson(json['leave']),
    );
  }

  @override
  List<AdminLeaveReportModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <AdminLeaveReportModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "organizationId": organizationId,
      "role": role,
      "name": name,
      "gender": gender,
      "firstName": firstName,
      "lastName": lastName,
      "image": image,
      "leave": leave?.toJson(),
    };
  }
}

class LeaveReportModel extends BaseModel<LeaveReportModel> {
  final String? type;
  final String? reason;
  final int? from;
  final int? to;
  final String? status;
  final String? durationType;
  final double? duration;

  LeaveReportModel({
    this.type,
    this.reason,
    this.from,
    this.to,
    this.status,
    this.durationType,
    this.duration,
  });

  @override
  LeaveReportModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LeaveReportModel();
    }
    return LeaveReportModel(
      type: json['type'],
      reason: json['reason'],
      from: json['from'],
      to: json['to'],
      status: json['status'],
      durationType: json['durationType'],
      duration: json['duration'],
    );
  }

  @override
  List<LeaveReportModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <LeaveReportModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'reason': reason,
      'from': from,
      'to': to,
      'status': status,
      'durationType': durationType,
      'duration': duration,
    };
  }
}
