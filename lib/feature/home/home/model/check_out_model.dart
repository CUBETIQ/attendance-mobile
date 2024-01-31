import 'package:timesync360/core/model/attendance_model.dart';

class CheckOutModel {
  final int? checkOutDateTime;
  final String? checkOutStatus;
  final String? checkOutType;
  final int? checkOutEarly;
  final int? checkOutLate;
  final LocationModel? checkOutLocation;

  CheckOutModel({
    this.checkOutDateTime,
    this.checkOutStatus,
    this.checkOutType,
    this.checkOutEarly,
    this.checkOutLate,
    this.checkOutLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      "checkOutDateTime": checkOutDateTime,
      "checkOutStatus": checkOutStatus,
      "checkOutType": checkOutType,
      "checkOutEarly": checkOutEarly,
      "checkOutLate": checkOutLate,
      "checkOutLocation": checkOutLocation?.toJson(),
    };
  }
}
