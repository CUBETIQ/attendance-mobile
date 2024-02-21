class DoubleUtil {
  static double caculatePercentageForProgress(int? value, int? total) {
    if (value == null || total == null) {
      return 0.0;
    }

    double? result;

    result = ((value / total) * 100) / 100;

    return result.isNaN ? 0.0 : result;
  }

  static double caculatePercentage(int? value, int? total) {
    if (value == null || total == null) {
      return 0.0;
    }

    double? result;

    result = (value / total) * 100;

    return result.isNaN ? 0.0 : result;
  }
}
