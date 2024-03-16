import 'package:timesync/core/model/attendance_model.dart';

class ScanQRModel {
  final int? datetime;
  final String? status;
  final String? type;
  final int? early;
  final int? late;
  final LocationModel? location;

  ScanQRModel({
    this.datetime,
    this.status,
    this.type,
    this.early,
    this.late,
    this.location,
  });
}
