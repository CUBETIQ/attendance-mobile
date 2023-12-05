import 'package:attendance_app/core/repositories/base_model.dart';

class UserModel extends BaseModel<UserModel> {
  final String? id;
  final String? username;
  final String? organizationId;
  final String? role;
  final String? name;
  final String? positionId;
  final String? departmentId;
  final String? firstName;
  final String? lastName;
  final int? dateOfBirth;
  final String? address;
  final String? image;
  final bool? enabled;

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
    this.image,
    this.enabled,
  });

  @override
  UserModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UserModel();
    }
    return UserModel(
      id: json['id'],
      username: json['username'],
      organizationId: json['organizationId'],
      role: json['role'],
      name: json['name'],
      positionId: json['positionId'],
      departmentId: json['departmentId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      image: json['image'],
      enabled: json['enabled'],
    );
  }

  @override
  List<UserModel> fromListJson(List<dynamic>? listJson) {
    if (listJson == null) {
      return [];
    }
    return listJson.map<UserModel>((e) => UserModel().fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'organizationId': organizationId,
      'role': role,
      'name': name,
      'positionId': positionId,
      'departmentId': departmentId,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'image': image,
      'enabled': enabled,
    };
  }
}
