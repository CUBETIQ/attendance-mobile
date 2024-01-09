class ChangePasswordModel {
  final String oldPassword;
  final String newPassword;

  ChangePasswordModel({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
  }
}
