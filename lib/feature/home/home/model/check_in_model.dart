import 'package:timesync/core/model/attendance_model.dart';

class CheckInModel {
  final int? checkInDateTime;
  final String? checkInStatus;
  final String? checkInType;
  final int? checkInEarly;
  final int? checkInLate;
  final LocationModel? checkInLocation;

  CheckInModel({
    this.checkInDateTime,
    this.checkInStatus,
    this.checkInType,
    this.checkInEarly,
    this.checkInLate,
    this.checkInLocation,
  });
}
