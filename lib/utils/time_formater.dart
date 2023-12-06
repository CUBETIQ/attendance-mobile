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
}
