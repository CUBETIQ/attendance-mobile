import 'package:attendance_app/core/repositories/base_model.dart';

class TaskModel extends BaseModel<TaskModel> {
  final String? id;
  final String? userId;
  final String? organizationId;
  final String? departmentId;
  final String? positionId;
  final String? taskName;
  final String? taskDescription;
  final String? taskType;
  final String? taskStatus;
  final int? startDate;
  final int? endDate;

  TaskModel({
    this.id,
    this.userId,
    this.organizationId,
    this.departmentId,
    this.positionId,
    this.taskName,
    this.taskDescription,
    this.taskType,
    this.taskStatus,
    this.startDate,
    this.endDate,
  });

  @override
  TaskModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TaskModel();
    }
    return TaskModel(
      id: json['id'],
      userId: json['userId'],
      organizationId: json['organizationId'],
      departmentId: json['departmentId'],
      positionId: json['positionId'],
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      taskType: json['taskType'],
      taskStatus: json['taskStatus'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  @override
  List<TaskModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <TaskModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "organizationId": organizationId,
      "departmentId": departmentId,
      "positionId": positionId,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "taskType": taskType,
      "taskStatus": taskStatus,
      "startDate": startDate,
      "endDate": endDate,
    };
  }
}
