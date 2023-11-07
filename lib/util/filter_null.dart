String validateString(dynamic data) {
  if (data == null) {
    return "";
  }
  return data;
}

int validateInt(dynamic data) {
  if (data == null) {
    return 0;
  }
  return data;
}

bool validateBool(dynamic data) {
  if (data == null) {
    return false;
  }
  return data;
}

double validateDouble(dynamic data) {
  if (data == null) {
    return 0.0;
  } else if (data is int) {
    return data.toDouble();
  }
  return data;
}
