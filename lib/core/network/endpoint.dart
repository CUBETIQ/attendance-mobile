class Endpoints {
  Endpoints._();

  static final Endpoints _instance = Endpoints._();

  static Endpoints get instance => _instance;

  static const String baseUrl = "http://localhost:3000/api";

  String get login => "/auth/login";
}
