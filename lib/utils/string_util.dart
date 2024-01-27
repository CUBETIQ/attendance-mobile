class StringUtil {
  String getfullname(String? firstName, String? lastName, String? username) {
    if ((firstName != null && firstName.isNotEmpty) &&
        (lastName != null && lastName.isNotEmpty)) {
      return "$firstName $lastName";
    } else if ((firstName != null && firstName.isNotEmpty) &&
        (lastName == null || lastName.isEmpty == true)) {
      return firstName;
    } else if ((firstName == null || firstName.isEmpty == true) &&
        (lastName != null && lastName.isNotEmpty)) {
      return lastName;
    } else {
      return username ?? "";
    }
  }
}
