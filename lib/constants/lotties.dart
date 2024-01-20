class LottieAssets {
  static final LottieAssets _instance = LottieAssets._internal();

  factory LottieAssets() {
    return _instance;
  }

  LottieAssets._internal();

  static const String lottieSplash = 'assets/lotties/splash.json';
  static const String lottieActivation = 'assets/lotties/activation.json';
  static const String loadingLight = 'assets/lotties/loading_light.json';
  static const String loadingDark = 'assets/lotties/loading_dark.json';
}
