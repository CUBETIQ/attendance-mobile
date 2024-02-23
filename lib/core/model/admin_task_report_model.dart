import 'package:timesync360/core/repositories/base_model.dart';

class AdminTaskReportModel extends BaseModel<AdminTaskReportModel> {
  final String? username;
  final String? organizationId;
  final String? role;
  final String? name;
  final String? gender;
  final String? firstName;
  final String? lastName;
  final String? image;
  final List<TaskReportModel>? task;

  AdminTaskReportModel({
    this.username,
    this.organizationId,
    this.role,
    this.name,
    this.gender,
    this.firstName,
    this.lastName,
    this.image,
    this.task,
  });

  @override
  AdminTaskReportModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AdminTaskReportModel();
    }
    return AdminTaskReportModel(
      username: json['username'],
      organizationId: json['organizationId'],
      role: json['role'],
      name: json['name'],
      gender: json['gender'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
      task: TaskReportModel().fromListJson(json['task']),
    );
  }

  @override
  List<AdminTaskReportModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return [];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "organizationId": organizationId,
      "role": role,
      "name": name,
      "gender": gender,
      "firstName": firstName,
      "lastName": lastName,
      "image": image,
      "task": task,
    };
  }
}

class TaskReportModel extends BaseModel<TaskReportModel> {
  final String? name;
  final String? description;
  final String? priority;
  final String? status;
  final int? startDate;
  final int? endDate;
  final int? completedDate;
  final List<String>? attachment;
  final String? color;
  final String? icon;

  TaskReportModel({
    this.name,
    this.description,
    this.priority,
    this.status,
    this.startDate,
    this.endDate,
    this.completedDate,
    this.attachment,
    this.color,
    this.icon,
  });

  @override
  TaskReportModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TaskReportModel();
    }
    return TaskReportModel(
      name: json['name'],
      description: json['description'],
      priority: json['priority'],
      status: json['status'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      completedDate: json['completedDate'],
      attachment: json['attachment'].cast<String>(),
      color: json['color'],
      icon: json['icon'],
    );
  }

  @override
  List<TaskReportModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return [];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "priority": priority,
      "status": status,
      "startDate": startDate,
      "endDate": endDate,
      "completedDate": completedDate,
      "attachment": attachment,
      "color": color,
      "icon": icon,
    };
  }
}
