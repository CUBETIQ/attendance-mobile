// ignore_for_file: non_constant_identifier_names

class Endpoints {
  Endpoints._();

  static final Endpoints _instance = Endpoints._();

  static Endpoints get instance => _instance;

  static const String baseUrl = "http://localhost:3000/api";

  String get login => "/auth/login";
  String get refreshToken => "/auth/token";
  String get get_own_profile => "/app/profile/me";
}
