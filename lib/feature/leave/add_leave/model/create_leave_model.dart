class CreateLeaveModel {
  final String? type;
  final String? reason;
  final int? from;
  final int? to;
  final String? durationType;

  CreateLeaveModel({
    this.type,
    this.reason,
    this.from,
    this.to,
    this.durationType,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "reason": reason,
      "from": from,
      "to": to,
      "durationType": durationType,
    };
  }
}
