// ignore_for_file: constant_identifier_names

class AppSpacing {
  static final AppSpacing _instance = AppSpacing._internal();

  factory AppSpacing() {
    return _instance;
  }

  AppSpacing._internal();

  static const double XS4 = 1.0;
  static const double XS3 = 2.0;
  static const double XS2 = 4.0;
  static const double XS = 6.0;
  static const double S = 8.0;
  static const double M = 12.0;
  static const double L = 16.0;
  static const double XL = 20.0;
  static const double XL2 = 24.0;
  static const double XL3 = 32.0;
  static const double XL4 = 40.0;
  static const double XL5 = 46.0;

  // padding textfield
  static const double paddingVerticalTextField = 14.0;
}
