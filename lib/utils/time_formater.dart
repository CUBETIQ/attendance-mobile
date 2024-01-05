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
}
