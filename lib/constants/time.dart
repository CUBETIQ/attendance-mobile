class AppTimeouts {
  static final AppTimeouts _instance = AppTimeouts._internal();

  factory AppTimeouts() {
    return _instance;
  }

  AppTimeouts._internal();

  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;
}
