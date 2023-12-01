class UserModel {
  String? id;
  String? username;
  String? organizationId;
  String? role;
  String? name;
  String? positionId;
  String? departmentId;
  String? firstName;
  String? lastName;
  int? dateOfBirth;
  String? address;
  bool? enabled;

  UserModel({
    this.id,
    this.username,
    this.organizationId,
    this.role,
    this.name,
    this.positionId,
    this.departmentId,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.address,
    this.enabled,
  });
}
