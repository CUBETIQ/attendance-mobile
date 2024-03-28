import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timesync/utils/logger.dart';

class DateUtil {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('E, d MMMM y').format(dateTime);
  }

  static String formatShortDate(DateTime dateTime) {
    // Define the desired format
    final DateFormat formatter =
        DateFormat('d MMMM, y', Get.locale?.languageCode);

    // Format the DateTime
    return formatter.format(dateTime);
  }

  static String formatShortDateWithoutDay(DateTime dateTime) {
    // Define the desired format
    final DateFormat formatter =
        DateFormat('MMMM, y', Get.locale?.languageCode);

    // Format the DateTime
    return formatter.format(dateTime);
  }

  static String formatShortDateWithMilisecond(int? dateTime) {
    if (dateTime == null || dateTime.toString().length < 5) {
      return "-";
    }

    // Cover milliseconds to DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateTime);

    // Define the desired format
    final DateFormat formatter =
        DateFormat('EE, dd MMMM', Get.locale?.languageCode);

    // Format the DateTime
    return formatter.format(date);
  }

  static String formatFullDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "-";
    }

    // Define the desired format
    final DateFormat formatter =
        DateFormat('EEEE d MMMM, y', Get.locale?.languageCode);

    // Format the DateTime
    return formatter.format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    // Define the desired time format
    final DateFormat formatter = DateFormat(
      'hh:mm a',
    );

    // Format the DateTime
    return formatter.format(dateTime);
  }

  static String formatTimeWithDate(int? dateTime) {
    if (dateTime == null || dateTime.toString().length < 5) {
      return "-";
    }

    // Cover milliseconds to DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateTime);

    // Define the desired time format
    final DateFormat formatter = DateFormat('h:mm a', Get.locale?.languageCode);

    // Format the DateTime
    return formatter.format(date);
  }

  static String formatTimeNoTrailing(
    DateTime dateTime,
  ) {
    // Define the desired time format
    final DateFormat formatter =
        DateFormat('hh:mm a', Get.locale?.languageCode);

    // Format the DateTime
    return formatter.format(dateTime);
  }

  static String formatTimeTo12Hour(String time,
      {bool? forceShowPM, bool? dontShowAMPM}) {
    // Parse the time string into a DateTime object
    DateTime dateTime = DateFormat('hh:mm').parse(time);

    if (forceShowPM != null && forceShowPM) {
      return "${DateFormat('hh:mm').format(dateTime)} PM";
    } else if (dontShowAMPM != null && dontShowAMPM) {
      return DateFormat('hh:mm').format(dateTime);
    } else {
      // Format the DateTime object into a 12-hour time format
      return DateFormat('hh:mm a').format(dateTime);
    }
  }

  static String formatMinutesToDays(int minutes) {
    // Calculate days
    int days = minutes ~/ (24 * 60); // Assuming 24 hours in a day

    // Format the time
    String formattedTime = '$days day${days != 1 ? 's' : ''}';

    return formattedTime;
  }

  static String formatMinutes(int minutes) {
    // Calculate hours and remaining minutes

    if (minutes == 0) {
      return "-";
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    // Format the result as a string
    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  static String formatMillisecondsToDOB(int? milliseconds) {
    if (milliseconds == null || milliseconds.toString().length < 5) {
      return "-";
    }
    // Cover milliseconds to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    // Format the result as a string
    return DateFormat('dd/MM/yyyy', Get.locale?.languageCode).format(dateTime);
  }

  static int calculateDurationInMinutes(
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

  static String getHourMinuteSecondFromMinute(int? minutes) {
    if (minutes == null || minutes == 0) {
      return "-";
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

  static int? getStartOfDayInMilisecond(DateTime? picked) {
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

  static int? getEndOfDayInMilisecond(DateTime? date) {
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

  static int? getStartOfMonthInMilliseconds(DateTime? picked) {
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

  static int? getEndOfMonthInMilliseconds(DateTime? date) {
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

  static int calculateTotalMinutes(String startHour, String endHour) {
    DateTime startTime = DateTime(2022, 1, 1,
        int.parse(startHour.split(":")[0]), int.parse(startHour.split(":")[1]));
    DateTime endTime = DateTime(2022, 1, 1, int.parse(endHour.split(":")[0]),
        int.parse(endHour.split(":")[1]));

    Duration difference = endTime.difference(startTime);

    Logs.i("difference: $difference");

    return difference.inMinutes;
  }

  static String calculateDuration(String? startHour, String? endHour) {
    // check if startHour or endHour is null
    if (startHour == null || endHour == null) {
      return "-";
    }

    // Parse startHour and endHour strings into DateTime objects
    DateTime startTime = DateFormat('HH:mm').parse(startHour);
    DateTime endTime = DateFormat('HH:mm').parse(endHour);

    Logs.i("startTime: $startTime");
    Logs.i("endTime: $endTime");

    // Calculate the duration between startTime and endTime
    int duration = endTime.difference(startTime).inMinutes;

    Logs.i("duration: $duration");

    // Format the duration as "hh:mm"
    String formattedDuration = formatMinutes(duration);

    return formattedDuration;
  }

  static bool isWithinFiveMinutes(int? dateTimeInMillis) {
    // Check if the parameter is null
    if (dateTimeInMillis == null) {
      return false;
    }

    // Convert parameter dateTimeInMillis to DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateTimeInMillis);

    // Get the current DateTime
    DateTime now = DateTime.now();

    // Calculate the difference in minutes
    int differenceInMinutes = now.difference(dateTime).inMinutes;

    // Check if the difference is greater than or equal to 3 minutes
    return differenceInMinutes < 3;
  }

  static void scheduleTaskAfterFiveMinutes(
      DateTime originalDateTime, int minute, void Function(bool) task) {
    bool isDisable = true;

    // Calculate the duration until 5 minutes from the original datetime
    Duration durationUntilFiveMinutesLater = originalDateTime
        .add(Duration(minutes: minute))
        .difference(DateTime.now());

    // Declare the timer variable
    Timer? timer;

    // Schedule a timer to run after the calculated duration
    timer = Timer(durationUntilFiveMinutesLater, () {
      // This block of code will run after 5 minutes from the original datetime
      // You can perform your task here
      isDisable = false;
      task.call(isDisable);

      // Cancel the timer
      timer?.cancel();
    });
  }

  static String getApplicationDuration(double? input) {
    if (input == null) {
      return '0 day application';
    }

    if (input == 0.5) {
      return 'Half Day Application';
    } else if (input == 1) {
      return 'Full Day Application';
    } else if (input >= 2) {
      return '${input.toStringAsFixed(0)} Days Application';
    } else {
      return 'Invalid input';
    }
  }
}

/////////////////////////////////


