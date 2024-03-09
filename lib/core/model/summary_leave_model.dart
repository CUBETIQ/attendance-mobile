import 'package:timesync/core/repositories/base_model.dart';

class SummaryLeaveModel extends BaseModel<SummaryLeaveModel> {
  final String? userId;
  final String? organizationId;
  final String? departmentId;
  final String? positionId;
  final int? date;
  final int? totalPendingLeave;
  final int? totalApprovedLeave;
  final int? totalRejectedLeave;

  SummaryLeaveModel({
    this.userId,
    this.organizationId,
    this.departmentId,
    this.positionId,
    this.date,
    this.totalPendingLeave,
    this.totalApprovedLeave,
    this.totalRejectedLeave,
  });

  @override
  SummaryLeaveModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SummaryLeaveModel();
    }
    return SummaryLeaveModel(
      userId: json['userId'],
      organizationId: json['organizationId'],
      departmentId: json['departmentId'],
      positionId: json['positionId'],
      date: json['date'],
      totalPendingLeave: json['totalPendingLeave'],
      totalApprovedLeave: json['totalApprovedLeave'],
      totalRejectedLeave: json['totalRejectedLeave'],
    );
  }

  @override
  List<SummaryLeaveModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <SummaryLeaveModel>[];
    }
    return listJson.map((e) => SummaryLeaveModel().fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "organizationId": organizationId,
      "departmentId": departmentId,
      "positionId": positionId,
      "date": date,
      "totalPendingLeave": totalPendingLeave,
      "totalApprovedLeave": totalApprovedLeave,
      "totalRejectedLeave": totalRejectedLeave,
    };
  }
}
