import 'package:timezone/timezone.dart' as tz;

class AppTime {
  static final AppTime _instance = AppTime._internal();

  factory AppTime() {
    return _instance;
  }

  AppTime._internal();

  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  static tz.TZDateTime scheduleTimeForCheckin({int? hour, int? min}) {
    
    return tz.TZDateTime(
      tz.local,
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour ?? 12,
      min ?? 00,
      00,
    );
  }

  static tz.TZDateTime scheduleTimeForCheckout({int? hour, int? min}) {
    return tz.TZDateTime(
      tz.local,
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour ?? 21,
      min ?? 00,
      00,
    );
  }
}
