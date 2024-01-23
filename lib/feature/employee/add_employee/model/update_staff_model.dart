class UpdateStaffModel {
  final String? username;
  final String? role;
  final String? organizationId;
  final String? name;
  final String? positionId;
  final String? departmentId;
  final String? firstName;
  final String? lastName;
  final int? dateOfBirth;
  final String? gender;
  final String? address;
  final String? status;
  final String? image;
  final String? email;

  UpdateStaffModel({
    this.username,
    this.role,
    this.organizationId,
    this.name,
    this.positionId,
    this.departmentId,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.address,
    this.status,
    this.image,
    this.email,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "role": role,
      "organizationId": organizationId,
      "name": name,
      "positionId": positionId,
      "departmentId": departmentId,
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "address": address,
      "status": status,
      "image": image,
      "email": email,
      "gender": gender,
    };
  }
}
