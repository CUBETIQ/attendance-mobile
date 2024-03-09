import 'package:timesync/core/model/organization_model.dart';

class UpdateOrganizationModel {
  final String? name;
  final String? address;
  final String? description;
  final String? image;
  final ConfigsModel? configs;

  UpdateOrganizationModel({
    this.name,
    this.address,
    this.description,
    this.image,
    this.configs,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "description": description,
      "image": image,
      "configs": configs?.toJson(),
    };
  }
}
