import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timesync/utils/size_util.dart';

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

  const MyDatePickerField({
    super.key,
    required this.label,
    required this.textController,
    this.filled = false,
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
  });

  @override
  Widget build(BuildContext context) {
    final controller = MyTextFieldFormController.findController(label);
    final size = MediaQuery.of(context).size;
    DateTime? resultDate;
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
                    style: labelStyle ?? AppFonts().bodyMediumMedium,
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
                  locale: Get.locale,
                );
                if (picked != null) {
                  if (label == "Start Date") {
                    resultDate = picked;
                  } else if (label == "Due Date" || label == "End Date") {
                    resultDate = DateTime(
                        picked.year, picked.month, picked.day, 23, 59, 59);
                  } else {
                    resultDate = picked;
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
                    horizontal: SizeUtils.scale(30.0, size.width),
                    vertical: SizeUtils.scale(14.0, size.width)),
                hintText: hintText,
                hintStyle: hintStyle ?? AppFonts().bodyMediumMedium,
                filled: filled ?? false,
                fillColor: filled == true
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.095)
                    : null,
                isDense: true,
                errorMaxLines: 2,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.scale(
                      borderRadius ?? AppSpacing.M,
                      size.width,
                    ),
                  ),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.scale(
                      borderRadius ?? AppSpacing.M,
                      size.width,
                    ),
                  ),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.scale(
                      borderRadius ?? AppSpacing.M,
                      size.width,
                    ),
                  ),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.scale(
                      borderRadius ?? AppSpacing.M,
                      size.width,
                    ),
                  ),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                errorStyle: errorStyle ?? AppFonts().bodyXSmallMedium,
              ),
              style: style ?? AppFonts().bodyMediumMedium,
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
