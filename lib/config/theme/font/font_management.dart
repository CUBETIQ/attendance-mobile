class FontManagement {
  static String fontFamily = 'Kamrang';
  static const String fontInter = 'Inter';
  static const String fontKamRang = 'Kamrang';
  static const List<String> fontFallBack = [fontKamRang, fontInter];
  FontManagement._();
  static void setFontFamily(String lang) {
    if (lang == 'km') {
      fontFamily = FontManagement.fontKamRang;
    } else {
      fontFamily = FontManagement.fontInter;
    }
  }
}
