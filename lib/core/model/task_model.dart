import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/repositories/base_model.dart';

class TaskModel extends BaseModel<TaskModel> {
  final String? id;
  final String? userId;
  final String? organizationId;
  final String? departmentId;
  final String? positionId;
  final String? name;
  final String? description;
  final String? status;
  final int? startDate;
  final int? endDate;
  final int? completedDate;
  final String? color;
  final String? icon;
  final String? priority;
  final List<AttachmentModel>? attachment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TaskModel({
    this.id,
    this.userId,
    this.organizationId,
    this.departmentId,
    this.positionId,
    this.name,
    this.description,
    this.status,
    this.priority,
    this.startDate,
    this.endDate,
    this.completedDate,
    this.color,
    this.icon,
    this.attachment,
    this.createdAt,
    this.updatedAt,
  });

  @override
  TaskModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TaskModel();
    }

    final createdDate =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    final updatedDate =
        json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;

    return TaskModel(
      id: json['id'],
      userId: json['userId'],
      organizationId: json['organizationId'],
      departmentId: json['departmentId'],
      positionId: json['positionId'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      startDate: json['startDate'],
      completedDate: json['completedDate'],
      priority: json['priority'],
      endDate: json['endDate'],
      color: json['color'],
      icon: json['icon'],
      createdAt: createdDate,
      updatedAt: updatedDate,
      attachment: AttachmentModel().fromListJson(json['attachment']),
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
      "name": name,
      "description": description,
      "status": status,
      "priority": priority,
      "startDate": startDate,
      "endDate": endDate,
      "color": color,
      "icon": icon,
      "attachment": attachment?.map((e) => e.toJson()).toList(),
    };
  }
}
