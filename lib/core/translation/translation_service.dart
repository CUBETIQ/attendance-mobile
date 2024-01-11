import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class ServiceTranslation extends Translations {
  List<LocalizationsDelegate<dynamic>> delegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
        },
        'km_KH': {
          'hello': 'សួស្តីពិភពលោក',
        },
      };
}
