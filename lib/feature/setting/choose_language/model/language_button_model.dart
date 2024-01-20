class LanguageButtonModel {
  final String code;
  final String title;
  final String imageFlag;
  final bool? isSelected;

  LanguageButtonModel({
    required this.code,
    required this.imageFlag,
    required this.title,
    this.isSelected,
  });
}
