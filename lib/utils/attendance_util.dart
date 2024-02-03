import 'package:timesync360/types/attendance_status.dart';

class CheckInStatusValidator {
  String getStatus(String hour, DateTime checkInTime) {
    int startHour = int.parse(hour.split(":")[0]);
    int checkInHour = checkInTime.hour;
    int checkInMinute = checkInTime.minute;

    if (checkInHour < startHour) {
      return AttendanceStatus.early;
    } else if (checkInHour == startHour && checkInMinute <= 10) {
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
    } else if (checkOutHour == endHour && checkOutMinute <= 10) {
      return AttendanceStatus.onTime;
    } else {
      return AttendanceStatus.late;
    }
  }
}

class GetMinute {
  int? checkLateMinute(String hour, DateTime checkInTime) {
    int startHour = int.parse(hour.split(":")[0]);
    int startMinute = int.parse(hour.split(":")[1]);

    int checkInHour = checkInTime.hour;
    int checkInMinute = checkInTime.minute;

    if (checkInHour < startHour ||
        (checkInHour == startHour && checkInMinute < startMinute)) {
      return null;
    } else if (checkInHour == startHour && checkInMinute <= startMinute + 10) {
      return null;
    } else {
      // Calculate late minutes
      int lateMinutes =
          (checkInHour - startHour) * 60 + (checkInMinute - startMinute);
      return lateMinutes;
    }
  }

  int? checkEarlyMinute(String hour, DateTime checkInTime) {
    int startHour = int.parse(hour.split(":")[0]);
    int startMinute = int.parse(hour.split(":")[1]);

    int checkInHour = checkInTime.hour;
    int checkInMinute = checkInTime.minute;

    if (checkInHour < startHour ||
        (checkInHour == startHour && checkInMinute < startMinute)) {
      // Calculate early minutes
      int earlyMinutes =
          (startHour - checkInHour) * 60 + (startMinute - checkInMinute);
      return earlyMinutes;
    } else if (checkInHour == startHour && checkInMinute <= startMinute + 10) {
      return null;
    } else {
      return null;
    }
  }
}
