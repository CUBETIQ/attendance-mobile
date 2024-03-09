import 'package:timesync/core/model/attachment_model.dart';

class CreateLeaveModel {
  final String? type;
  final String? reason;
  final int? from;
  final int? to;
  final String? durationType;
  final double? duration;
  final int? requestDate;
  final List<AttachmentModel>? attachment;

  CreateLeaveModel({
    this.type,
    this.reason,
    this.from,
    this.to,
    this.durationType,
    this.duration,
    this.requestDate,
    this.attachment,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "reason": reason,
      "from": from,
      "to": to,
      "durationType": durationType,
      "duration": duration,
      "requestDate": requestDate,
      "attachment": attachment?.map((e) => e.toJson()).toList(),
    };
  }
}
