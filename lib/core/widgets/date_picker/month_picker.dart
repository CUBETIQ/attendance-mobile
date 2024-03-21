import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

monthPicker({required BuildContext context, DateTime? initialDate}) {
  FocusScope.of(context).unfocus();
  return showMonthPicker(
    context: context,
    locale: Get.locale,
    initialDate: initialDate,
    firstDate: DateTime(2019),
    lastDate: DateTime(2050),
    roundedCornersRadius: 24,
    animationMilliseconds: 0,
    dismissible: true,
    selectedMonthTextColor: Theme.of(context).colorScheme.onPrimary,
    selectedMonthBackgroundColor: Theme.of(context).colorScheme.primary,
    currentMonthTextColor: Theme.of(context).colorScheme.primary,
    unselectedMonthTextColor: Theme.of(context).colorScheme.onBackground,
    backgroundColor: Theme.of(context).colorScheme.background,
    headerColor: Theme.of(context).colorScheme.primary,
    headerTextColor: Theme.of(context).colorScheme.onPrimary,
  );
}
