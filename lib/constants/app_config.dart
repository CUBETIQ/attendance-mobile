// ignore_for_file: constant_identifier_names

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  static const double DEFAULT_LOCATION_RADIUS = 200;
}
