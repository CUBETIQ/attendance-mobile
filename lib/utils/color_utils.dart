import 'package:flutter/material.dart';
import 'package:timesync/types/attendance.dart';
import 'package:timesync/types/leave.dart';

class ColorUtil {
  static bool isColorBright(Color color) {
    // Calculate luminance
    double luminance = color.computeLuminance();

    // Choose a threshold value based on your preference
    double threshold = 0.5;

    // Check if the color is bright or dark
    return luminance > threshold;
  }

  static Color generateGradientColor(Color color, double factor) {
    // Adjust the brightness or saturation as needed
    return Color.fromARGB(
      color.alpha,
      (color.red * (1 - factor)).round(),
      (color.green * (1 - factor)).round(),
      (color.blue * (1 - factor)).round(),
    );
  }

  /// Darken a color by [percent] amount (100 = black)
// ........................................................
  static Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }

  /// Lighten a color by [percent] amount (100 = white)
// ........................................................
  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round());
  }

  static Color getStatusColor(BuildContext context, String? status,
      {bool? isCheckOut, bool? noOnTimeColor}) {
    switch (status) {
      case AttendanceStatus.early:
        return Theme.of(context).colorScheme.tertiary;
      case AttendanceStatus.onTime:
        return noOnTimeColor == true
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary;
      case AttendanceStatus.late:
        return isCheckOut == true
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.error;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  static Color getStatusColorByLeaveStatus(
      BuildContext context, String? status) {
    switch (status) {
      case LeaveStatus.approved:
        return Theme.of(context).colorScheme.tertiary;
      case LeaveStatus.pending:
        return Theme.of(context).colorScheme.tertiaryContainer;
      case LeaveStatus.rejected:
        return Theme.of(context).colorScheme.error;
      case LeaveStatus.cancelled:
        return Theme.of(context).colorScheme.error;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }
}
