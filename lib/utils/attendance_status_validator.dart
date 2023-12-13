import 'package:attendance_app/utils/types_helper/attendance_status.dart';

class CheckInStatusValidator {
  String getStatus(String hour, DateTime checkInTime) {
    int startHour = int.parse(hour.split(":")[0]);
    int checkInHour = checkInTime.hour;
    int checkInMinute = checkInTime.minute;

    if (checkInHour < startHour) {
      return AttendanceStatus.early;
    } else if (checkInHour == startHour && checkInMinute <= 15) {
      return AttendanceStatus.onTime;
    } else {
      return AttendanceStatus.late;
    }
  }
}

class CheckOutStatusValidator {
  String getStatus(String hour, DateTime checkOutTime) {
    int endHour = int.parse(hour.split(":")[0]);
    int checkOutHour = checkOutTime.hour;
    int checkOutMinute = checkOutTime.minute;

    if (checkOutHour < endHour) {
      return AttendanceStatus.early;
    } else if (checkOutHour == endHour && checkOutMinute <= 15) {
      return AttendanceStatus.onTime;
    } else {
      return AttendanceStatus.late;
    }
  }
}
