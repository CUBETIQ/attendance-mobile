class UpdateLeaveModel {
  final String? type;
  final String? reason;
  final int? from;
  final int? to;
  final String? durationType;
  final double? duration;

  UpdateLeaveModel({
    this.type,
    this.reason,
    this.from,
    this.to,
    this.durationType,
    this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "reason": reason,
      "from": from,
      "to": to,
      "durationType": durationType,
      "duration": duration,
    };
  }
}
