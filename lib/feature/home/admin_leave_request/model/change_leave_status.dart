class ChangeLeaveStatusModel {
  final String? status;
  final int? updateDate;

  ChangeLeaveStatusModel({
    this.status,
    this.updateDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "updateDate": updateDate,
    };
  }
}
