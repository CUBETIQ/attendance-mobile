import 'package:timesync/core/repositories/base_model.dart';

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
  final LocationModel? checkInLocation;
  final LocationModel? checkOutLocation;
  final int? duration;
  final List<dynamic>? attachment;

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
    this.checkInLocation,
    this.checkOutLocation,
    this.duration,
    this.attachment,
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
      attachment: json['attachment'],
      checkInLocation: LocationModel().fromJson(json['checkInLocation']),
      checkOutLocation: LocationModel().fromJson(json['checkOutLocation']),
      duration: json['duration'],
    );
  }

  @override
  List<AttendanceModel> fromListJson(List? listJson) {
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
      'attachment': attachment,
      'checkInLocation': checkInLocation?.toJson(),
      'checkOutLocation': checkOutLocation?.toJson(),
      'duration': duration,
    };
  }
}

class LocationModel extends BaseModel<LocationModel> {
  final double? lat;
  final double? lng;
  final bool? inOffice;

  LocationModel({
    this.lat,
    this.lng,
    this.inOffice,
  });

  @override
  LocationModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LocationModel();
    }
    return LocationModel(
      lat: json['lat'],
      lng: json['lng'],
      inOffice: json['inOffice'],
    );
  }

  @override
  List<LocationModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return [];
    }
    return listJson
        .map<LocationModel>((e) => LocationModel().fromJson(e))
        .toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'inOffice': inOffice,
    };
  }
}
