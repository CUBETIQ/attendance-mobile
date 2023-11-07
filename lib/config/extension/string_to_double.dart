
extension DoubleExtension on String {
  // int
  get toDouble {
    if (isNotEmpty) {
      return double.parse(this);
    }
    return null;
  }
}
