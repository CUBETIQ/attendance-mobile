import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timesync/utils/size_util.dart';

class MyTimePickerField extends StatelessWidget {
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
  final void Function(String?)? onDateResult;

  const MyTimePickerField({
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
    this.onDateResult,
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
                    style: labelStyle ?? AppFonts().bodyMediumMedium,
                  ),
            SizedBox(
              height: SizeUtils.scale(hasLabel == false ? 0 : 6, size.width),
            ),
            TextFormField(
              readOnly: true,
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  initialEntryMode: TimePickerEntryMode.dial,
                );
                if (picked != null) {
                  // Format hour and minute with leading zeros
                  String formattedTime = DateFormat.Hm().format(
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day, picked.hour, picked.minute),
                  );

                  // Throw back the data through the function
                  onDateResult?.call(formattedTime);

                  // formate to diplay with am and pm
                  String formattedTime12 = DateFormat.jm().format(
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day, picked.hour, picked.minute),
                  );

                  textController.text = formattedTime12;
                }
              },
              controller: textController,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(AppSize().paddingS17, size.width),
                  vertical: SizeUtils.scale(AppSize().paddingS7, size.width),
                ),
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
