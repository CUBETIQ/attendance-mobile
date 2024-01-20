import 'dart:ui';
import 'package:attendance_app/core/database/isar/controller/local_language_controller.dart';
import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/translate/service/index.dart';
import 'package:attendance_app/utils/converter.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();

  final LocalStorageController _localStorage =
      LocalStorageController.getInstance();
  final LanguageLocalStorageController _languageLocalStorage =
      LanguageLocalStorageController.getInstance();

  RxMap<String, String> langEN = <String, String>{}.obs;
  RxMap<String, String> langKH = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initTranslation();
  }

  Future<Map<String, String>> getTranslation({required String lang}) async {
    try {
      final Map<String, String> getLang =
          await TranslateService().getTranslate(param: lang);
      return getLang;
    } on Exception catch (e) {
      showErrorSnackBar("Error", e.toString());
      rethrow;
    }
  }

  Future<void> initTranslation() async {
    final appConfig = await _localStorage.get();
    final languageConfig = await _languageLocalStorage.get();
    if (languageConfig?.enUS != null && languageConfig?.kmKH != null) {
      langEN.value =
          Map<String, String>.from(fromJson(languageConfig?.enUS ?? ""));
      langKH.value =
          Map<String, String>.from(fromJson(languageConfig?.kmKH ?? ""));
    } else {
      langEN.value = await getTranslation(lang: "en");
      langKH.value = await getTranslation(lang: "km");
      await IsarService().saveLanguage(
        enLang: toJson(langEN.value),
        kmLang: toJson(langKH.value),
      );
    }
    final local = Locale(appConfig?.language ?? 'en');
    Get.updateLocale(local);
  }
}
