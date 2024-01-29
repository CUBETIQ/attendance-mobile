class UpdateUserStatusModel {
  final String? status;
  final int? lastUpdatedAt;

  UpdateUserStatusModel({
    this.status,
    this.lastUpdatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'lastUpdatedAt': lastUpdatedAt,
    };
  }
}
