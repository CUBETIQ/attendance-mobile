import 'package:attendance_app/core/repositories/base_model.dart';

class SummaryAttendanceModel extends BaseModel<SummaryAttendanceModel> {
  final String? id;
  final String? date;
  final int? totalAttendance;
  final int? totalAbsent;
  final int? totalLeave;

  SummaryAttendanceModel({
    this.id,
    this.date,
    this.totalAttendance,
    this.totalAbsent,
    this.totalLeave,
  });

  @override
  SummaryAttendanceModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SummaryAttendanceModel();
    }
    return SummaryAttendanceModel(
      id: json['id'],
      date: json['date'],
      totalAttendance: json['totalAttendance'],
      totalAbsent: json['totalAbsent'],
      totalLeave: json['totalLeave'],
    );
  }

  @override
  List<SummaryAttendanceModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <SummaryAttendanceModel>[];
    }
    return listJson.map((e) => SummaryAttendanceModel().fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "totalAttendance": totalAttendance,
      "totalAbsent": totalAbsent,
      "totalLeave": totalLeave,
    };
  }
}
