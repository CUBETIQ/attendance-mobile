import 'package:cubetiq_attendance_app/config/translation/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

class ServiceTranslation extends Translations {
  List<LocalizationsDelegate<dynamic>> delegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  final LanguageController languageController = Get.find();
  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': languageController.langEN, 'km_KH': languageController.langKH};
}
