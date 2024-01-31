class ChangeLeaveStatusModel {
  final String? status;
  final int? updatedDate;

  ChangeLeaveStatusModel({
    this.status,
    this.updatedDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "updatedDate": updatedDate,
    };
  }
}
