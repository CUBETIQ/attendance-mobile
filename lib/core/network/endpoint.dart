// ignore_for_file: non_constant_identifier_names

class Endpoints {
  Endpoints._();

  static final Endpoints _instance = Endpoints._();

  static Endpoints get instance => _instance;

  static const String baseUrl = "http://192.168.1.102:3000/api";

  String get login => "/auth/login";
  String get refreshToken => "/auth/token";
  String get activation => "/auth/activation/activate";
  String get deactivation => "/auth/activation/deactivate";
  String get get_own_profile => "/app/profile/me";
}
