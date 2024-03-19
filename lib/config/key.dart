class Key {
  static final Key _instance = Key._internal();

  factory Key() {
    return _instance;
  }

  Key._internal();

  // DEV
  static const String vfsClientPublicKey = '25882306345b5b05ea796bc421b15b62';
  static const String vfsClientApiKey = 'fb73ce111f0ddde0e56569aa31fc8d30';

  // PROD
  // static const String vfsClientPublicKey = '577553517a76666b4e6a4f65673d0a';
  // static const String vfsClientApiKey = '444b2b6e6356584d37736134513d0a';
}
