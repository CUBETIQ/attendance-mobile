import 'package:timesync360/core/model/attachment_model.dart';

class CreateTaskModel {
  final String? name;
  final String? description;
  final int? startDate;
  final int? endDate;
  final String? color;
  final String? icon;
  final String? priority;
  final List<AttachmentModel>? attachment;

  CreateTaskModel({
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.color,
    this.icon,
    this.priority,
    this.attachment,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "color": color,
      "icon": icon,
      "priority": priority,
      "attachment": attachment?.map((e) => e.toJson()).toList(),
    };
  }
}
