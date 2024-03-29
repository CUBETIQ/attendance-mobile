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
  final int? checkInEarly;
  final int? checkInLate;
  final List<dynamic>? trackTimelineId;
  final int? checkOutDateTime;
  final String? checkOutType;
  final int? checkOutEarly;
  final int? checkOutLate;
  final String? checkOutStatus;
  final BreakTimeModel? breakTime;
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
    this.checkInEarly,
    this.checkInLate,
    this.trackTimelineId,
    this.checkOutDateTime,
    this.checkOutType,
    this.checkOutEarly,
    this.checkOutLate,
    this.checkOutStatus,
    this.checkInLocation,
    this.checkOutLocation,
    this.duration,
    this.attachment,
    this.breakTime,
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
      checkInEarly: json['checkInEarly'],
      checkInLate: json['checkInLate'],
      trackTimelineId: json['trackTimelineId'],
      checkOutDateTime: json['checkOutDateTime'],
      checkOutType: json['checkOutType'],
      checkOutEarly: json['checkOutEarly'],
      checkOutLate: json['checkOutLate'],
      checkOutStatus: json['checkOutStatus'],
      attachment: json['attachment'],
      breakTime: BreakTimeModel().fromJson(json['breakTime']),
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
      'breakTime': breakTime?.toJson(),
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
    var lat = json['lat'];
    if (json['lat'] is int) {
      lat = double.parse(json['lat']);
    } else {
      lat = json['lat'];
    }

    var lng = json['lng'];
    if (json['lng'] is int) {
      lng = double.parse(json['lng']);
    } else {
      lng = json['lng'];
    }

    return LocationModel(
      lat: lat,
      lng: lng,
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

class BreakTimeModel extends BaseModel<BreakTimeModel> {
  final int? start;
  final int? end;
  final int? duration;

  BreakTimeModel({
    this.start,
    this.end,
    this.duration,
  });

  @override
  BreakTimeModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return BreakTimeModel();
    }
    return BreakTimeModel(
      start: json['start'],
      end: json['end'],
      duration: json['duration'],
    );
  }

  @override
  List<BreakTimeModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return [];
    }
    return listJson
        .map<BreakTimeModel>((e) => BreakTimeModel().fromJson(e))
        .toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
      'duration': duration,
    };
  }
}
