import 'package:attendance_app/core/repositories/base_model.dart';

class AttendanceChartModel extends BaseModel<AttendanceChartModel> {
  final int? totalStaff;
  final int? totalAttendance;
  final int? totalLeave;
  final int? totalAbsent;
  final List<dynamic>? users;

  AttendanceChartModel({
    this.totalStaff,
    this.totalAttendance,
    this.totalLeave,
    this.totalAbsent,
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
      "users": users,
    };
  }
}
