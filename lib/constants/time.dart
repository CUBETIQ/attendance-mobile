import 'package:timezone/timezone.dart' as tz;

class AppTime {
  static final AppTime _instance = AppTime._internal();

  factory AppTime() {
    return _instance;
  }

  AppTime._internal();

  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  static tz.TZDateTime scheduleTimeForCheckin = tz.TZDateTime(
    tz.local,
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    12,
    18,
    30,
  );

  static tz.TZDateTime scheduleTimeForCheckout = tz.TZDateTime(
    tz.local,
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    21,
    00,
    00,
  );
}
