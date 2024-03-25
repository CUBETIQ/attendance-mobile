import 'package:timezone/timezone.dart' as tz;

class AppTime {
  static final AppTime _instance = AppTime._internal();

  factory AppTime() {
    return _instance;
  }

  AppTime._internal();

  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  static tz.TZDateTime? scheduleToday({int? hour, int? min}) {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour ?? 12,
      min ?? 00,
      00,
    );

    return scheduledTime;
  }

  static tz.TZDateTime? scheduleSpecificDay({required DateTime? date}) {
    if (date == null) return null;
    tz.TZDateTime scheduledTime = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      00,
    );

    return scheduledTime;
  }
}
