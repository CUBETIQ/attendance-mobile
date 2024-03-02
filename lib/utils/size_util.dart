class SizeUtils {
  static double scaleMobile(double value, double width) {
    return value * (width / 375.0);
  }

  static double scaleTablet(double value, double width) {
    return value * (width / 600);
  }
}
