import 'package:timesync360/core/repositories/base_model.dart';

class AdminAttendanceReportModel extends BaseModel<AdminAttendanceReportModel> {
  final String? username;
  final String? position;
  final String? department;
  final String? role;
  final String? name;
  final String? gender;
  final String? firstName;
  final String? lastName;
  final String? image;
  final AttendanceReportModel? attendance;

  AdminAttendanceReportModel({
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
  AdminAttendanceReportModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AdminAttendanceReportModel();
    }
    return AdminAttendanceReportModel(
      username: json['username'],
      position: json['position'],
      department: json['department'],
      role: json['role'],
      name: json['name'],
      gender: json['gender'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
      attendance: AttendanceReportModel().fromJson(json['attendance']),
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
      'username': username,
      'position': position,
      'department': department,
      'role': role,
      'name': name,
      'gender': gender,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'attendance': attendance?.toJson(),
    };
  }
}

class AttendanceReportModel extends BaseModel<AttendanceReportModel> {
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
  final int? totalSession;

  AttendanceReportModel({
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
    this.totalSession,
  });

  @override
  AttendanceReportModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AttendanceReportModel();
    }
    return AttendanceReportModel(
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
      totalSession: json['totalSession'],
    );
  }

  @override
  List<AttendanceReportModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <AttendanceReportModel>[];
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
      'totalSession': totalSession,
    };
  }
}
