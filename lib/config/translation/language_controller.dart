import 'package:cubetiq_attendance_app/util/console.dart';
import 'package:cubetiq_attendance_app/config/translation/translation_model.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxMap<String, String> langEN = <String, String>{
    'hello': 'Hello world',
  }.obs;
  RxMap<String, String> langKH = <String, String>{
    'hello': 'សួស្ដី',
  }.obs;

  @override
  onInit() async {
    loadTranslations();
    super.onInit();
  }

  Future<Map<String, String>> getEnglish() async {
    try {
      final data = TranslationModel.fromJson({});
      return data.getKey;
    } catch (e) {
      Console.error("Error Language English", e);
      throw "Handle Server Error";
    }
  }

  Future<Map<String, String>> getKhmer() async {
    try {
      final data = TranslationModel.fromJson({});
      return data.getKey;
    } catch (e) {
      Console.error("Error Language Khmer", e);
      throw "Handle Server Error";
    }
  }

  Future<void> loadTranslations() async {
    Map<String, String> enUS = await getEnglish();
    Map<String, String> kmKH = await getKhmer();
    //   langEN.value = enUS;
    //   langKH.value = kmKH;
    //   final lg = Languages();
    //   lg.enUS = toJson(enUS);
    //   lg.kmKH = toJson(kmKH);
    //   await SettingService().setKeyLanguages(lg);
    // }
  }
}
