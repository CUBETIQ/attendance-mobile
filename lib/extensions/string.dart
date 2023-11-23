extension DoubleExtension on String {
  //convert string to int
  int toInt() {
    return int.tryParse(this) ?? 0;
  }

  //convert string to double
  double toDouble() {
    return double.tryParse(this) ?? 0.0; // Returns 0.0 if conversion fails
  }

  // Remove whitespace from the beginning and end of the string
  String trim() {
    return this.trim();
  }

  //capitalize first letter
  String capitalizeFirstLetter() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  // Capitalize the first letter of each word in the string
  String capitalizeEachWord() {
    return split(' ').map((word) => word.capitalizeFirstLetter()).join(' ');
  }

  //validate email
  bool isValidEmail() {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        caseSensitive: false);
    return emailRegex.hasMatch(this);
  }

  //validate url
  bool isValidUrl() {
    final urlRegex =
        RegExp(r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$', caseSensitive: false);
    return urlRegex.hasMatch(this);
  }
}
