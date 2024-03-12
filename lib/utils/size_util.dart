class SizeUtils {
  static double scale(double value, double width) {
    return value *
        (width /
            (width < 600
                ? 375.0
                : width < 950
                    ? 600
                    : 900));
  }
}
