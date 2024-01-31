import 'package:timesync360/core/repositories/base_model.dart';

class SummaryTaskModel extends BaseModel<SummaryTaskModel> {
  final String? userId;
  final String? organizationId;
  final String? departmentId;
  final String? positionId;
  final int? date;
  final int? totalTask;
  final int? totalTaskDone;
  final int? totalTaskNotDone;

  SummaryTaskModel({
    this.userId,
    this.organizationId,
    this.departmentId,
    this.positionId,
    this.date,
    this.totalTask,
    this.totalTaskDone,
    this.totalTaskNotDone,
  });

  @override
  SummaryTaskModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SummaryTaskModel();
    }
    return SummaryTaskModel(
      userId: json['userId'],
      organizationId: json['organizationId'],
      departmentId: json['departmentId'],
      positionId: json['positionId'],
      date: json['date'],
      totalTask: json['totalTask'],
      totalTaskDone: json['totalTaskDone'],
      totalTaskNotDone: json['totalTaskNotDone'],
    );
  }

  @override
  List<SummaryTaskModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <SummaryTaskModel>[];
    }
    return listJson.map((e) => SummaryTaskModel().fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "organizationId": organizationId,
      "departmentId": departmentId,
      "positionId": positionId,
      "date": date,
      "totalTask": totalTask,
      "totalTaskDone": totalTaskDone,
      "totalTaskNotDone": totalTaskNotDone,
    };
  }
}
