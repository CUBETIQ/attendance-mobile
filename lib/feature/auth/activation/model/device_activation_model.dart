import 'package:timesync/core/repositories/base_model.dart';

class DeviceActivationModel extends BaseModel<DeviceActivationModel> {
  final String? id;
  final String? deviceId;
  final OrganizationFromHash? organization;

  DeviceActivationModel({
    this.id,
    this.deviceId,
    this.organization,
  });

  @override
  DeviceActivationModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DeviceActivationModel();
    }
    return DeviceActivationModel(
      id: json['id'],
      deviceId: json['deviceId'],
      organization: OrganizationFromHash().fromJson(json['organization']),
    );
  }

  @override
  List<DeviceActivationModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <DeviceActivationModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "deviceId": deviceId,
      "organization": organization?.toJson(),
    };
  }
}

class OrganizationFromHash extends BaseModel<OrganizationFromHash> {
  final String? id;
  final String? name;
  final String? image;

  OrganizationFromHash({
    this.id,
    this.name,
    this.image,
  });

  @override
  OrganizationFromHash fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return OrganizationFromHash();
    }
    return OrganizationFromHash(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  @override
  List<OrganizationFromHash> fromListJson(List? listJson) {
    if (listJson == null) {
      return <OrganizationFromHash>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
    };
  }
}
