// ignore_for_file: must_be_immutable

import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyDatePickerField extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final bool? filled;
  final double? borderRadius;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool? hasLabel;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isPassword;
  final void Function(int?)? onDateResult;
  final DateTime? initialDate;
  final DateTime? firstDate;
  DateTime? resultDate;

  MyDatePickerField({
    super.key,
    required this.label,
    required this.textController,
    this.filled = true,
    this.borderRadius,
    this.style,
    this.errorStyle,
    this.hintText,
    this.hintStyle,
    this.hasLabel = false,
    this.labelStyle,
    this.textCapitalization,
    this.inputFormatters,
    this.isPassword,
    this.onDateResult,
    this.initialDate,
    this.firstDate,
    this.resultDate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = MyTextFieldFormController.findController(label);
    final size = MediaQuery.of(context).size;
    return GetBuilder<MyTextFieldFormController>(
      init: controller,
      builder: (_) => Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hasLabel == false
                ? const SizedBox.shrink()
                : MyText(
                    text: label,
                    style: labelStyle ?? BodyMediumMedium,
                  ),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: initialDate ?? DateTime.now(),
                  firstDate: firstDate ?? DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  if (label == "Start Date") {
                    resultDate = picked;
                  } else {
                    resultDate = DateTime(
                        picked.year, picked.month, picked.day, 23, 59, 59);
                  }
                  // Throw back the data through the function
                  onDateResult?.call(resultDate!.millisecondsSinceEpoch);
                  textController.text = DateFormat('dd/MM/yyyy').format(picked);
                }
              },
              controller: textController,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              inputFormatters: inputFormatters,
              obscureText: isPassword ?? false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: (AppSize.paddingS17) * (size.width / 375.0),
                  vertical: (AppSize.paddingS7) * (size.width / 375.0),
                ),
                hintText: hintText,
                hintStyle: hintStyle ?? BodyMediumMedium,
                filled: filled ?? false,
                fillColor: filled == true
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
                isDense: true,
                errorMaxLines: 2,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      (borderRadius ?? AppSize.borderRadiusSmall) *
                          (size.width / 375.0),
                    ),
                    topRight: Radius.circular(
                      (borderRadius ?? AppSize.borderRadiusSmall) *
                          (size.width / 375.0),
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      (borderRadius ?? AppSize.borderRadiusSmall) *
                          (size.width / 375.0),
                    ),
                    topRight: Radius.circular(
                      (borderRadius ?? AppSize.borderRadiusSmall) *
                          (size.width / 375.0),
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      (borderRadius ?? AppSize.borderRadiusSmall) *
                          (size.width / 375.0),
                    ),
                    topRight: Radius.circular(
                      (borderRadius ?? AppSize.borderRadiusSmall) *
                          (size.width / 375.0),
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      (borderRadius ?? AppSize.borderRadiusSmall) *
                          (size.width / 375.0),
                    ),
                    topRight: Radius.circular(
                      (borderRadius ?? AppSize.borderRadiusSmall) *
                          (size.width / 375.0),
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                errorStyle: errorStyle ?? BodyXSmallMedium,
              ),
              style: style ?? BodyMediumMedium,
              onChanged: (value) {
                controller.formKey.currentState?.validate();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '$label is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
