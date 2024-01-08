import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/config/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyTextFieldForm extends StatelessWidget {
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
  final IconData? prefixIcon;
  final int? maxlines;

  const MyTextFieldForm({
    super.key,
    required this.label,
    required this.textController,
    this.filled,
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
    this.prefixIcon,
    this.maxlines,
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
            const SizedBox(height: AppSize.paddingS5),
            TextFormField(
              controller: textController,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              inputFormatters: inputFormatters,
              obscureText: isPassword ?? false,
              maxLines: maxlines ?? 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: (AppSize.paddingS17) * (size.width / 375.0),
                  vertical: (AppSize.paddingS7) * (size.width / 375.0),
                ),
                prefixIcon: prefixIcon == null
                    ? null
                    : Icon(
                        prefixIcon,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                hintText: hintText,
                isDense: true,
                hintStyle: hintStyle ?? BodyMediumMedium,
                filled: filled ?? false,
                errorMaxLines: 2,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    (borderRadius ?? AppSize.borderRadiusLarge) *
                        (size.width / 375.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    (borderRadius ?? AppSize.borderRadiusLarge) *
                        (size.width / 375.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    (borderRadius ?? AppSize.borderRadiusLarge) *
                        (size.width / 375.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    (borderRadius ?? AppSize.borderRadiusLarge) *
                        (size.width / 375.0),
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
