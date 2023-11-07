class TranslationModel {
  TranslationModel({this.key});

  final Map<String, String>? key;

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    final convert = TranslationModel();
    var data = convert
        ._validator(json['getTranslationByLanguageKeyAndNamespace']['data']);
    final result = Map<String, String>.from(data);
    return TranslationModel(key: result);
  }

  factory TranslationModel.fromJsonLocal(Map<String, dynamic> json) {
    final result = Map<String, String>.from(json);
    return TranslationModel(key: result);
  }

  Map<String, String> get getKey => key!;

  Map<String, dynamic> _validator(dynamic map) {
    if (map == null) {
      return {};
    }
    return map;
  }
}
