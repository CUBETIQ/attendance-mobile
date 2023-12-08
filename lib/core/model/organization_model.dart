import 'package:attendance_app/core/repositories/base_model.dart';

class OrganizationModel extends BaseModel<OrganizationModel> {
  final String? name;
  final Location? location;
  final String? address;
  final String? description;
  final String? image;
  final String? createdBy;
  final int? limitStaff;
  final String? parentId;
  final Configs? configs;

  OrganizationModel({
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
        name: json['name'],
        location: Location().fromJson(json['location']),
        address: json['address'],
        description: json['description'],
        image: json['image'],
        createdBy: json['createdBy'],
        limitStaff: json['limitStaff'],
        parentId: json['parentId'],
        configs: Configs().fromJson(json['configs']));
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

class Location {
  final double? lat;
  final double? lng;

  Location({this.lat, this.lng});

  Location fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Location();
    }
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
    };
  }
}

class Configs {
  final String? startHour;
  final String? endHour;
  final String? breakTime;

  Configs({this.startHour, this.endHour, this.breakTime});

  Configs fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Configs();
    }
    return Configs(
      startHour: json['startHour'],
      endHour: json['endHour'],
      breakTime: json['breakTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "startHour": startHour,
      "endHour": endHour,
      "breakTime": breakTime,
    };
  }
}
