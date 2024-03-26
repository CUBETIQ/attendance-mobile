import 'package:intl/intl.dart';
import 'package:timesync/types/attendance_status.dart';

class StringUtil {
  static String getfullname(
      String? firstName, String? lastName, String? username) {
    if ((firstName != null && firstName.isNotEmpty) &&
        (lastName != null && lastName.isNotEmpty)) {
      return "$lastName $firstName";
    } else if ((firstName != null && firstName.isNotEmpty) &&
        (lastName == null || lastName.isEmpty == true)) {
      return firstName;
    } else if ((firstName == null || firstName.isEmpty == true) &&
        (lastName != null && lastName.isNotEmpty)) {
      return lastName;
    } else {
      return username ?? "N/A";
    }
  }

  static String doubleToPercentageString(double value) {
    // Convert the double to a string with two decimal places
    String stringValue = value.toStringAsFixed(2);

    // Remove trailing zeros after the decimal point
    if (stringValue.contains('.')) {
      stringValue = stringValue.replaceAll(RegExp(r'0*$'), '');
    }

    // Remove the decimal point if there are no decimal values remaining
    if (stringValue.endsWith('.')) {
      stringValue = stringValue.substring(0, stringValue.length - 1);
    }

    // Add a percentage sign at the end
    return '$stringValue%';
  }

  static String convertToJsonStringQuotes({required String raw}) {
    /// remove space
    String jsonString = raw.replaceAll(" ", "");

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(':', '": "');
    jsonString = jsonString.replaceAll(',', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }

  static String removeTrailingZeros(double? number) {
    if (number == null) {
      return "1";
    }

    String result = number.toString();

    // Remove trailing zeros and dot if no decimal part
    if (result.contains('.')) {
      result = result.replaceAll(RegExp(r'0*$'), '');
      result = result.replaceAll(RegExp(r'\.$'), '');
    }

    return result;
  }

  static String? calculateDurationWithStatus(int? minutes, String? status) {
    if (minutes == null || status == null) {
      return null;
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    String timeString = '';
    if (hours > 0) {
      timeString += '$hours hr';
      if (hours > 1) timeString += 's'; // pluralize 'hour' if needed
      timeString += ' ';
    }

    if (remainingMinutes > 0) {
      timeString += '$remainingMinutes min';
      if (remainingMinutes > 1) {
        timeString += 's'; // pluralize 'minute' if needed
      }
    }

    if (status == AttendanceStatus.late) {
      return timeString.isEmpty ? 'Late' : '$timeString late';
    } else if (status == AttendanceStatus.early) {
      return timeString.isEmpty ? 'Early' : '$timeString early';
    } else if (status == AttendanceStatus.onTime) {
      return 'On time';
    } else {
      return 'Invalid status';
    }
  }

  static String? calculateDuration(int? minutes, {bool? noMinutes}) {
    if (minutes == null || minutes == 0) {
      return "-";
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    String timeString = '';
    if (hours > 0) {
      timeString += '$hours hr';
      if (hours > 1) timeString += 's'; // pluralize 'hour' if needed
      timeString += ' ';
    }

    if (noMinutes != true) {
      if (remainingMinutes > 0) {
        timeString += '$remainingMinutes min';
        if (remainingMinutes > 1) {
          timeString += 's'; // pluralize 'minute' if needed
        }
      }
    }

    return timeString;
  }

  static String? getStatusByCalculateBreakTime(
      int? date, String? endBreakTime) {
    if (date == null || endBreakTime == null) {
      return null;
    }

    // End time = 13:00 (to_time('13:00', 'hh:mm'))
    DateTime endBreakTimeHour = DateFormat("hh:mm").parse(endBreakTime);

    DateTime getbreakTime = DateTime.fromMillisecondsSinceEpoch(date);

    DateTime breakTime = DateFormat("hh:mm")
        .parse("${getbreakTime.hour}:${getbreakTime.minute}");

    if (endBreakTimeHour.isBefore(breakTime)) {
      return AttendanceStatus.late;
    } else if (endBreakTimeHour.isAfter(breakTime)) {
      return AttendanceStatus.early;
    } else {
      return AttendanceStatus.onTime;
    }
  }

  static String? calculationDurationForBreakTime(
      int? date, String? endBreak, String? status) {
    if (date == null || endBreak == null || status == null) {
      return null;
    }

    DateTime endBreakTime = DateFormat("HH:mm").parse(endBreak);

    DateTime getbreakTime = DateTime.fromMillisecondsSinceEpoch(date);

    DateTime breakTime = DateFormat("HH:mm")
        .parse("${getbreakTime.hour}:${getbreakTime.minute}");

    final minutes = endBreakTime.difference(breakTime).inMinutes;

    int hours = (minutes ~/ 60).abs();
    int remainingMinutes = minutes % 60;

    String timeString = '';

    if (hours > 0) {
      timeString += '$hours hr';
      if (hours > 1) timeString += 's'; // pluralize 'hour' if needed
      timeString += ' ';
    }

    if (remainingMinutes > 0) {
      timeString += '$remainingMinutes min';
      if (remainingMinutes > 1) {
        timeString += 's'; // pluralize 'minute' if needed
      }
    }

    if (status == AttendanceStatus.late) {
      return timeString.isEmpty ? 'Late' : '$timeString late';
    } else if (status == AttendanceStatus.early) {
      return timeString.isEmpty ? 'Early' : '$timeString early';
    } else if (status == AttendanceStatus.onTime) {
      return 'On time';
    } else {
      return 'Invalid status';
    }
  }

  static String attendanceStatusSimplify(String? status) {
    if (status == null) {
      return "N/A";
    }

    if (status == AttendanceStatus.late) {
      return 'Late';
    } else if (status == AttendanceStatus.early) {
      return 'Early';
    } else if (status == AttendanceStatus.onTime) {
      return 'On time';
    } else {
      return 'Invalid status';
    }
  }
}
