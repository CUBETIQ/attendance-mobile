import 'package:attendance_app/core/repositories/base_model.dart';

class AdminReportModel extends BaseModel<AdminReportModel> {
  final String? username;
  final String? position;
  final String? department;
  final String? role;
  final String? name;
  final String? gender;
  final String? firstName;
  final String? lastName;
  final String? image;
  final List<AdminAttendanceReportModel>? attendance;

  AdminReportModel({
    this.username,
    this.position,
    this.department,
    this.role,
    this.name,
    this.gender,
    this.firstName,
    this.lastName,
    this.image,
    this.attendance,
  });

  @override
  AdminReportModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AdminReportModel();
    }
    return AdminReportModel(
      username: json['username'],
      position: json['position'],
      department: json['department'],
      role: json['role'],
      name: json['name'],
      gender: json['gender'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
      attendance: AdminAttendanceReportModel().fromListJson(json['attendance']),
    );
  }

  @override
  List<AdminReportModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <AdminReportModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'position': position,
      'department': department,
      'role': role,
      'name': name,
      'gender': gender,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'attendance': attendance?.map((e) => e.toJson()).toList(),
    };
  }
}

class AdminAttendanceReportModel extends BaseModel<AdminAttendanceReportModel> {
  final int? checkInDateTime;
  final String? checkInStatus;
  final int? checkOutDateTime;
  final String? checkOutStatus;
  final int? duration;

  AdminAttendanceReportModel({
    this.checkInDateTime,
    this.checkInStatus,
    this.checkOutDateTime,
    this.checkOutStatus,
    this.duration,
  });

  @override
  AdminAttendanceReportModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AdminAttendanceReportModel();
    }
    return AdminAttendanceReportModel(
      checkInDateTime: json['checkInDateTime'],
      checkInStatus: json['checkInStatus'],
      checkOutDateTime: json['checkOutDateTime'],
      checkOutStatus: json['checkOutStatus'],
      duration: json['duration'],
    );
  }

  @override
  List<AdminAttendanceReportModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <AdminAttendanceReportModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'checkInDateTime': checkInDateTime,
      'checkInStatus': checkInStatus,
      'checkOutDateTimel': checkOutDateTime,
      'checkOutStatus': checkOutStatus,
      'duration': duration,
    };
  }
}
