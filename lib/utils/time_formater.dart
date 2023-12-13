import 'package:intl/intl.dart';

class DateFormatter {
  String formatDate(DateTime dateTime) {
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
    final DateFormat formatter = DateFormat('h:mm');

    // Format the DateTime
    return formatter.format(dateTime);
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
    if (milliseconds == null) {
      return "N/A";
    }
    // Cover milliseconds to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    // Format the result as a string
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
