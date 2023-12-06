import 'package:attendance_app/core/repositories/base_model.dart';

class AttendanceModel extends BaseModel<AttendanceModel> {
  final String? id;
  final String? userId;
  final String? organizationId;
  final String? departmentId;
  final String? positionId;
  final int? checkInDateTime;
  final String? checkInStatus;
  final String? checkInType;
  final List<dynamic>? trackTimelineId;
  final int? checkOutDateTime;
  final String? checkOutType;
  final String? checkOutStatus;
  final Location? location;
  final int? duration;

  AttendanceModel({
    this.id,
    this.userId,
    this.organizationId,
    this.departmentId,
    this.positionId,
    this.checkInDateTime,
    this.checkInStatus,
    this.checkInType,
    this.trackTimelineId,
    this.checkOutDateTime,
    this.checkOutType,
    this.checkOutStatus,
    this.location,
    this.duration,
  });

  @override
  AttendanceModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AttendanceModel();
    }
    return AttendanceModel(
      id: json['id'],
      userId: json['userId'],
      organizationId: json['organizationId'],
      departmentId: json['departmentId'],
      positionId: json['positionId'],
      checkInDateTime: json['checkInDateTime'],
      checkInStatus: json['checkInStatus'],
      checkInType: json['checkInType'],
      trackTimelineId: json['trackTimelineId'],
      checkOutDateTime: json['checkOutDateTime'],
      checkOutType: json['checkOutType'],
      checkOutStatus: json['checkOutStatus'],
      location: Location().fromJson(json['location']),
      duration: json['duration'],
    );
  }

  @override
  List<AttendanceModel?> fromListJson(List? listJson) {
    if (listJson == null) {
      return [];
    }
    return listJson
        .map<AttendanceModel>((e) => AttendanceModel().fromJson(e))
        .toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'organizationId': organizationId,
      'departmentId': departmentId,
      'positionId': positionId,
      'checkInDateTime': checkInDateTime,
      'checkInStatus': checkInStatus,
      'checkInType': checkInType,
      'trackTimelineId': trackTimelineId,
      'checkOutDateTime': checkOutDateTime,
      'checkOutType': checkOutType,
      'checkOutStatus': checkOutStatus,
      'location': location,
      'duration': duration,
    };
  }
}

class Location extends BaseModel<Location> {
  final double? lat;
  final double? lng;

  Location({
    this.lat,
    this.lng,
  });

  @override
  Location fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Location();
    }
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  @override
  List<Location?> fromListJson(List? listJson) {
    if (listJson == null) {
      return [];
    }
    return listJson.map<Location>((e) => Location().fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
