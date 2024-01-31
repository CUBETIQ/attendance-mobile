import 'package:timesync360/config/app_size.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/config/font.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:timesync360/utils/size_util.dart';
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
  final bool? haveSuffixIcon;
  final void Function()? onTapShowPassword;

  const MyTextFieldForm({
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
    this.prefixIcon,
    this.maxlines,
    this.onTapShowPassword,
    this.haveSuffixIcon,
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
          mainAxisSize: MainAxisSize.min,
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
                  horizontal: SizeUtils.scale(AppSize.paddingS17, size.width),
                  vertical: SizeUtils.scale(AppSize.paddingS7, size.width),
                ),
                prefixIcon: prefixIcon == null
                    ? null
                    : Icon(
                        prefixIcon,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                suffixIcon: haveSuffixIcon == true
                    ? Padding(
                        padding: EdgeInsets.only(
                          right: SizeUtils.scale(10, size.width),
                        ),
                        child: GestureDetector(
                          onTap: onTapShowPassword,
                          child: Icon(
                            isPassword == false
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: Theme.of(context).colorScheme.onBackground,
                            size: SizeUtils.scale(20, size.width),
                          ),
                        ),
                      )
                    : null,
                hintText: hintText?.trString,
                isDense: true,
                hintStyle: hintStyle ?? BodyMediumMedium,
                filled: filled ?? false,
                fillColor: filled == true
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : null,
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
