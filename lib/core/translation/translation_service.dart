import 'package:timesync360/translate/controller/index.dart';
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

  final controller = LanguageController.to;

  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': controller.langEN, 'km_KH': controller.langKH};
}
