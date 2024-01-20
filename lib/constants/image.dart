class ImageAssets {
  static final ImageAssets _instance = ImageAssets._internal();

  factory ImageAssets() {
    return _instance;
  }

  ImageAssets._internal();

  static const String logoTimeSync360 = 'assets/images/logo_timesync360.png';
}
