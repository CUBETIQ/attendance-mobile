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
  final String? checkInType;
  final int? checkInEarly;
  final int? checkInLate;
  final int? checkOutDateTime;
  final String? checkOutStatus;
  final String? checkOutType;
  final int? checkOutEarly;
  final int? checkOutLate;
  final int? duration;

  AdminAttendanceReportModel({
    this.checkInDateTime,
    this.checkInStatus,
    this.checkInType,
    this.checkInEarly,
    this.checkInLate,
    this.checkOutDateTime,
    this.checkOutStatus,
    this.checkOutType,
    this.checkOutEarly,
    this.checkOutLate,
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
      checkInType: json['checkInType'],
      checkInEarly: json['checkInEarly'],
      checkInLate: json['checkInLate'],
      checkOutDateTime: json['checkOutDateTime'],
      checkOutStatus: json['checkOutStatus'],
      checkOutType: json['checkOutType'],
      checkOutEarly: json['checkOutEarly'],
      checkOutLate: json['checkOutLate'],
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
      'checkInType': checkInType,
      'checkInEarly': checkInEarly,
      'checkInLate': checkInLate,
      'checkOutDateTimel': checkOutDateTime,
      'checkOutStatus': checkOutStatus,
      'checkOutType': checkOutType,
      'checkOutEarly': checkOutEarly,
      'checkOutLate': checkOutLate,
      'duration': duration,
    };
  }
}
