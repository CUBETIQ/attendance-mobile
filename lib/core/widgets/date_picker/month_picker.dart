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
  );
}
