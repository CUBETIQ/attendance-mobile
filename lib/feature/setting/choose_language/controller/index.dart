import 'dart:ui';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/widgets/loading/loading_dialog.dart';
import 'package:timesync/feature/setting/choose_language/model/language_button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageController extends GetxController {
  final language = [
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
  final _localStorage = LocalStorageController.getInstance();
  final selectedLanguage = Rxn<LanguageButtonModel>();
  final isSelected = [false, false].obs;
  LocalStorageModel? localStorageData = LocalStorageModel();

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
    if (selectedLanguage.value == languageButtonModel) return;
    const LoadingDialog().show(
      size: size,
      title: "Changing Language",
    );
    selectedLanguage.value = languageButtonModel;
    isSelected.value = [false, false];
    isSelected[language.indexOf(languageButtonModel)] = true;
    if (selectedLanguage.value?.title == 'Khmer') {
      Get.updateLocale(Locale(selectedLanguage.value?.code ?? 'km'));
      localStorageData?.language = selectedLanguage.value?.code ?? 'km';
      await IsarService().saveLocalData(
        input: localStorageData,
      );
    } else {
      Get.updateLocale(Locale(selectedLanguage.value?.code ?? 'en'));
      localStorageData?.language = selectedLanguage.value?.code ?? 'en';
      await IsarService().saveLocalData(
        input: localStorageData,
      );
    }
    await Future.delayed(const Duration(seconds: 1));
    const LoadingDialog().dismiss();
  }
}
