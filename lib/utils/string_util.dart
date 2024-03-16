class StringUtil {
  static String getfullname(
      String? firstName, String? lastName, String? username) {
    if ((firstName != null && firstName.isNotEmpty) &&
        (lastName != null && lastName.isNotEmpty)) {
      return "$lastName $firstName";
    } else if ((firstName != null && firstName.isNotEmpty) &&
        (lastName == null || lastName.isEmpty == true)) {
      return firstName;
    } else if ((firstName == null || firstName.isEmpty == true) &&
        (lastName != null && lastName.isNotEmpty)) {
      return lastName;
    } else {
      return username ?? "N/A";
    }
  }

  static String doubleToPercentageString(double value) {
    // Convert the double to a string with two decimal places
    String stringValue = value.toStringAsFixed(2);

    // Remove trailing zeros after the decimal point
    if (stringValue.contains('.')) {
      stringValue = stringValue.replaceAll(RegExp(r'0*$'), '');
    }

    // Remove the decimal point if there are no decimal values remaining
    if (stringValue.endsWith('.')) {
      stringValue = stringValue.substring(0, stringValue.length - 1);
    }

    // Add a percentage sign at the end
    return '$stringValue%';
  }

  static String convertToJsonStringQuotes({required String raw}) {
    /// remove space
    String jsonString = raw.replaceAll(" ", "");

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(':', '": "');
    jsonString = jsonString.replaceAll(',', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }

  static String removeTrailingZeros(double? number) {
    if (number == null) {
      return "1";
    }

    String result = number.toString();

    // Remove trailing zeros and dot if no decimal part
    if (result.contains('.')) {
      result = result.replaceAll(RegExp(r'0*$'), '');
      result = result.replaceAll(RegExp(r'\.$'), '');
    }

    return result;
  }
}
