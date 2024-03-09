import 'package:timesync/core/model/attachment_model.dart';

class UpdateLeaveModel {
  final String? type;
  final String? reason;
  final int? from;
  final int? to;
  final String? durationType;
  final double? duration;
  final List<AttachmentModel>? attachment;

  UpdateLeaveModel({
    this.type,
    this.reason,
    this.from,
    this.to,
    this.durationType,
    this.duration,
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
      "attachment": attachment?.map((e) => e.toJson()).toList(),
    };
  }
}
