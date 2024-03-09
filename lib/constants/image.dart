class ImageAssets {
  static final ImageAssets _instance = ImageAssets._internal();

  factory ImageAssets() {
    return _instance;
  }

  ImageAssets._internal();

  static const String logotimesync = 'assets/images/logo_timesync.png';
}
