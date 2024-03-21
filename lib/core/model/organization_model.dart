import 'package:timesync/core/repositories/base_model.dart';
import 'package:timesync/extensions/string.dart';

class OrganizationModel extends BaseModel<OrganizationModel> {
  final String? id;
  final String? name;
  final OranizationLocationModel? location;
  final String? address;
  final String? description;
  final String? image;
  final String? createdBy;
  final int? limitStaff;
  final String? parentId;
  final ConfigsModel? configs;

  OrganizationModel({
    this.id,
    this.name,
    this.location,
    this.address,
    this.description,
    this.image,
    this.createdBy,
    this.limitStaff,
    this.parentId,
    this.configs,
  });

  @override
  OrganizationModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return OrganizationModel();
    }
    return OrganizationModel(
        id: json['id'],
        name: json['name'],
        location: OranizationLocationModel().fromJson(json['location']),
        address: json['address'],
        description: json['description'],
        image: json['image'],
        createdBy: json['createdBy'],
        limitStaff: json['limitStaff'],
        parentId: json['parentId'],
        configs: ConfigsModel().fromJson(json['configs']));
  }

  @override
  List<OrganizationModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <OrganizationModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "location": location?.toJson(),
      "address": address,
      "description": description,
      "image": image,
      "createdBy": createdBy,
      "limitStaff": limitStaff,
      "parentId": parentId,
      "configs": configs?.toJson(),
    };
  }
}

class OranizationLocationModel {
  final double? lat;
  final double? lng;

  OranizationLocationModel({this.lat, this.lng});

  OranizationLocationModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return OranizationLocationModel();
    }

    return OranizationLocationModel(
      lat: json['lat'] is int ? json['lat'].toString().toDouble() : json['lat'],
      lng: json['lng'] is int ? json['lng'].toString().toDouble() : json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
    };
  }
}

class ConfigsModel {
  final String? startHour;
  final String? endHour;
  final String? breakTime;
  final String? breakDuration;

  ConfigsModel({
    this.startHour,
    this.endHour,
    this.breakTime,
    this.breakDuration,
  });

  ConfigsModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ConfigsModel();
    }
    return ConfigsModel(
      startHour: json['startHour'],
      endHour: json['endHour'],
      breakTime: json['breakTime'],
      breakDuration: json['breakDuration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "startHour": startHour,
      "endHour": endHour,
      "breakTime": breakTime,
      "breakDuration": breakDuration,
    };
  }
}
