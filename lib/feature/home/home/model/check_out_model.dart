import 'package:attendance_app/core/model/attendance_model.dart';

class CheckOutModel {
  final int? checkOutDateTime;
  final String? checkOutStatus;
  final String? checkOutType;
  final LocationModel? checkOutLocation;

  CheckOutModel({
    this.checkOutDateTime,
    this.checkOutStatus,
    this.checkOutType,
    this.checkOutLocation,
  });
}
