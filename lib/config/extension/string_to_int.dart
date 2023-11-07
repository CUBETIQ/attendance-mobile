extension IntegerExtension on String {
  // int
  get toInt {
    if (isNotEmpty) {
      return int.parse(this);
    }
    return null;
  }
}
