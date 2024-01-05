import 'package:attendance_app/core/model/attendance_model.dart';

class CheckInModel {
  final int? checkInDateTime;
  final String? checkInStatus;
  final String? checkInType;
  final LocationModel? checkInLocation;

  CheckInModel({
    this.checkInDateTime,
    this.checkInStatus,
    this.checkInType,
    this.checkInLocation,
  });
}
