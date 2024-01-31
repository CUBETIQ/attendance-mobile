import 'dart:ui';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync360/core/database/isar/service/isar_service.dart';
import 'package:timesync360/core/widgets/loading/loading_dialog.dart';
import 'package:timesync360/feature/setting/choose_language/model/language_button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageController extends GetxController {
  RxList<LanguageButtonModel> language = [
    LanguageButtonModel(
      code: 'km',
      imageFlag: SvgAssets.cambodiaFlag,
      title: 'Khmer',
    ),
    LanguageButtonModel(
      code: 'en',
      imageFlag: SvgAssets.usFlag,
      title: 'English',
    ),
  ].obs;
  final LocalStorageController _localStorage =
      LocalStorageController.getInstance();
  Rxn<LanguageButtonModel> selectedLanguage = Rxn<LanguageButtonModel>();
  RxList<bool> isSelected = [false, false].obs;

  @override
  void onInit() {
    super.onInit();
    initLanguage();
  }

  Future<void> initLanguage() async {
    final localData = await _localStorage.get();
    if (localData?.language == 'km') {
      selectedLanguage.value = language[0];
      isSelected.value = [true, false];
    } else {
      selectedLanguage.value = language[1];
      isSelected.value = [false, true];
    }
  }

  Future<void> changeLanguage(
      LanguageButtonModel languageButtonModel, Size size) async {
    const LoadingDialog().show(
      size: size,
      title: "Changing Language",
    );
    if (selectedLanguage.value == languageButtonModel) return;
    selectedLanguage.value = languageButtonModel;
    isSelected.value = [false, false];
    isSelected[language.indexOf(languageButtonModel)] = true;
    if (selectedLanguage.value?.title == 'Khmer') {
      Get.updateLocale(Locale(selectedLanguage.value?.code ?? 'km'));
      await IsarService().saveLocalData(
        language: selectedLanguage.value?.code ?? 'km',
      );
    } else {
      Get.updateLocale(Locale(selectedLanguage.value?.code ?? 'en'));
      await IsarService().saveLocalData(
        language: selectedLanguage.value?.code ?? 'en',
      );
    }
    await Future.delayed(const Duration(seconds: 1));
    const LoadingDialog().dismiss();
  }
}
