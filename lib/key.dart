class Key {
  static final Key _instance = Key._internal();

  factory Key() {
    return _instance;
  }

  Key._internal();

  static const String secretKey =
      'hyAi2YFjTKWwjpQ7NsfKkGNQXlrVZ1y26VMbX9aKScs=';
}
