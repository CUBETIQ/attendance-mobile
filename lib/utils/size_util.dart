class SizeUtils {
  static double scale(double value, double width) {
    return value *
        (width /
            (width < 600
                ? 375.0
                : width < 1100
                    ? 600
                    : 900));
  }
}
