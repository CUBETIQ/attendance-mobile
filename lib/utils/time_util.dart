import 'package:intl/intl.dart';

class DateFormatter {
  String formatDateTime(DateTime dateTime) {
    return DateFormat('E, d MMMM y').format(dateTime);
  }

  String formatShortDate(DateTime dateTime) {
    // Define the desired format
    final DateFormat formatter = DateFormat('d MMMM, y');

    // Format the DateTime
    return formatter.format(dateTime);
  }

  String formatShortDateWithoutDay(DateTime dateTime) {
    // Define the desired format
    final DateFormat formatter = DateFormat('MMMM, y');

    // Format the DateTime
    return formatter.format(dateTime);
  }

  String formatFullDate(DateTime dateTime) {
    // Define the desired format
    final DateFormat formatter = DateFormat('EEEE d MMMM, y');

    // Format the DateTime
    return formatter.format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    // Define the desired time format
    final DateFormat formatter = DateFormat('h:mm a');

    // Format the DateTime
    return formatter.format(dateTime);
  }

  String formatTimeWithDate(int? dateTime) {
    if (dateTime == null || dateTime.toString().length < 5) {
      return "N/A";
    }

    // Cover milliseconds to DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateTime);

    // Define the desired time format
    final DateFormat formatter = DateFormat('h:mm a');

    // Format the DateTime
    return formatter.format(date);
  }

  String formatTimeNoTrailing(DateTime dateTime) {
    // Define the desired time format
    final DateFormat formatter = DateFormat('h:mm a');

    // Format the DateTime
    return formatter.format(dateTime);
  }

  String formatMinutesToDays(int minutes) {
    // Calculate days
    int days = minutes ~/ (24 * 60); // Assuming 24 hours in a day

    // Format the time
    String formattedTime = '$days day${days != 1 ? 's' : ''}';

    return formattedTime;
  }

  String formatMinutes(int minutes) {
    // Calculate hours and remaining minutes

    if (minutes == 0) {
      return "N/A";
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    // Format the result as a string
    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  String formatMillisecondsToDOB(int? milliseconds) {
    if (milliseconds == null || milliseconds.toString().length < 5) {
      return "N/A";
    }
    // Cover milliseconds to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    // Format the result as a string
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  int calculateDurationInMinutes(
      int startDateMilliseconds, int? endDateMilliseconds) {
    // Convert start date from milliseconds to DateTime
    DateTime startDate =
        DateTime.fromMillisecondsSinceEpoch(startDateMilliseconds);

    // Convert end date from milliseconds to DateTime, or use DateTime.now() if end date is null
    DateTime endDate = endDateMilliseconds != null
        ? DateTime.fromMillisecondsSinceEpoch(endDateMilliseconds)
        : DateTime.now();

    // Calculate the duration in minutes
    Duration duration = endDate.difference(startDate);
    return duration.inMinutes;
  }

  String getHourMinuteSecondFromMinute(int? minutes) {
    if (minutes == null || minutes == 0) {
      return "N/A";
    }

    int hours = minutes ~/ 60; // Integer division to get hours
    int remainingMinutes = minutes % 60;

    // Construct the formatted string
    String result = '';
    result += '$hours h ';

    if (remainingMinutes > 0 || hours == 0) {
      result += '$remainingMinutes min';
    }

    return result.isNotEmpty ? result : 'N/A';
  }
}

/////////////////////////////////

class DateTimeUtil {
  int? getStartOfDayInMilisecond(DateTime? picked) {
    if (picked != null) {
      DateTime startOfDayDateTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
        0,
        0,
        0,
      );
      return startOfDayDateTime.millisecondsSinceEpoch;
    }

    return null;
  }

  int? getEndOfDayInMilisecond(DateTime? date) {
    if (date != null) {
      DateTime endOfDayDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        23,
        59,
        59,
      );
      return endOfDayDateTime.millisecondsSinceEpoch;
    }

    return null;
  }

  int? getStartOfMonthInMilliseconds(DateTime? picked) {
    if (picked != null) {
      DateTime startOfMonthDateTime = DateTime(
        picked.year,
        picked.month,
        1, // Day 1 represents the start of the month
        0,
        0,
        0,
      );
      return startOfMonthDateTime.millisecondsSinceEpoch;
    }

    return null;
  }

  int? getEndOfMonthInMilliseconds(DateTime? date) {
    if (date != null) {
      DateTime endOfMonthDateTime = DateTime(
        date.year,
        date.month + 1, // Move to the next month
        0, // Day 0 of the next month is the last day of the current month
        23,
        59,
        59,
      );
      return endOfMonthDateTime.millisecondsSinceEpoch;
    }

    return null;
  }

  int calculateTotalMinutes(String startHour, String endHour) {
    DateTime startTime = DateTime(2022, 1, 1,
        int.parse(startHour.split(":")[0]), int.parse(startHour.split(":")[1]));
    DateTime endTime = DateTime(2022, 1, 1, int.parse(endHour.split(":")[0]),
        int.parse(endHour.split(":")[1]));

    Duration difference = endTime.difference(startTime);
    return difference.inMinutes;
  }
}
