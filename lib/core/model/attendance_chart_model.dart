import 'package:attendance_app/core/repositories/base_model.dart';

class AttendanceChartModel extends BaseModel<AttendanceChartModel> {
  final int? totalStaff;
  final int? totalAttendance;
  final int? totalLeave;
  final int? totalAbsent;
  final int? totalCheckinLate;
  final int? totalCheckinEarly;
  final int? totalCheckinOnTime;
  final int? totalCheckoutLate;
  final int? totalCheckoutEarly;
  final int? totalCheckoutOnTime;
  final List<dynamic>? users;

  AttendanceChartModel({
    this.totalStaff,
    this.totalAttendance,
    this.totalLeave,
    this.totalAbsent,
    this.totalCheckinLate,
    this.totalCheckinEarly,
    this.totalCheckinOnTime,
    this.totalCheckoutLate,
    this.totalCheckoutEarly,
    this.totalCheckoutOnTime,
    this.users,
  });

  @override
  AttendanceChartModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AttendanceChartModel();
    }
    return AttendanceChartModel(
      totalStaff: json['totalStaff'],
      totalAttendance: json['totalAttendance'],
      totalLeave: json['totalLeave'],
      totalAbsent: json['totalAbsent'],
      totalCheckinLate: json['totalCheckinLate'],
      totalCheckinEarly: json['totalCheckinEarly'],
      totalCheckinOnTime: json['totalCheckinOnTime'],
      totalCheckoutLate: json['totalCheckoutLate'],
      totalCheckoutEarly: json['totalCheckoutEarly'],
      totalCheckoutOnTime: json['totalCheckoutOnTime'],
      users: json['users'],
    );
  }

  @override
  List<AttendanceChartModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <AttendanceChartModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "totalStaff": totalStaff,
      "totalAttendance": totalAttendance,
      "totalLeave": totalLeave,
      "totalAbsent": totalAbsent,
      "totalCheckinLate": totalCheckinLate,
      "totalCheckinEarly": totalCheckinEarly,
      "totalCheckinOnTime": totalCheckinOnTime,
      "totalCheckoutLate": totalCheckoutLate,
      "totalCheckoutEarly": totalCheckoutEarly,
      "totalCheckoutOnTime": totalCheckoutOnTime,
      "users": users,
    };
  }
}
