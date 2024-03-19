import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/size_util.dart';
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
  final double? iconSize;
  final int? maxlines;
  final bool? haveSuffixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final void Function()? onTapShowPassword;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final void Function(String)? onChanged;

  const MyTextFieldForm(
      {super.key,
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
      this.errorText,
      this.focusNode,
      this.onTapShowPassword,
      this.haveSuffixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.iconSize,
      this.onTap,
      this.onChanged});

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
              height: SizeUtils.scale(AppSize().paddingS5, size.width),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Theme.of(context).colorScheme.error,
              ),
              child: TextFormField(
                focusNode: focusNode,
                controller: textController,
                textCapitalization:
                    textCapitalization ?? TextCapitalization.none,
                inputFormatters: inputFormatters,
                obscureText: isPassword ?? false,
                maxLines: maxlines ?? 1,
                keyboardType: keyboardType,
                onTap: onTap,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(AppSize().paddingS7, size.width),
                  ),
                  prefix: prefixIcon == null
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: SizeUtils.scale(
                              AppSize().paddingS17,
                              size.width,
                            ),
                          ),
                        )
                      : null,
                  suffix: prefixIcon == null
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: SizeUtils.scale(
                              AppSize().paddingS17,
                              size.width,
                            ),
                          ),
                        )
                      : null,
                  prefixIcon: prefixIcon == null
                      ? null
                      : Icon(
                          prefixIcon,
                          size: iconSize,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  suffixIcon: haveSuffixIcon == true
                      ? Padding(
                          padding: EdgeInsets.only(
                            right: SizeUtils.scale(10, size.width),
                          ),
                          child: suffixIcon ??
                              GestureDetector(
                                onTap: onTapShowPassword,
                                child: Icon(
                                  isPassword == false
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  size: SizeUtils.scale(20, size.width),
                                ),
                              ),
                        )
                      : null,
                  hintText: hintText?.trString,
                  isDense: true,
                  hintStyle: hintStyle ?? AppFonts().bodyMediumMedium,
                  filled: filled ?? false,
                  fillColor: filled == true
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.095)
                      : null,
                  errorText: errorText,
                  errorMaxLines: 2,
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        SizeUtils.scale(
                            borderRadius ?? AppSize().borderRadiusSmall,
                            size.width),
                      ),
                      topRight: Radius.circular(
                        SizeUtils.scale(
                            borderRadius ?? AppSize().borderRadiusSmall,
                            size.width),
                      ),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.9),
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        SizeUtils.scale(
                            borderRadius ?? AppSize().borderRadiusSmall,
                            size.width),
                      ),
                      topRight: Radius.circular(
                        SizeUtils.scale(
                            borderRadius ?? AppSize().borderRadiusSmall,
                            size.width),
                      ),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.9),
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        SizeUtils.scale(
                            borderRadius ?? AppSize().borderRadiusSmall,
                            size.width),
                      ),
                      topRight: Radius.circular(
                        SizeUtils.scale(
                            borderRadius ?? AppSize().borderRadiusSmall,
                            size.width),
                      ),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        SizeUtils.scale(
                            borderRadius ?? AppSize().borderRadiusSmall,
                            size.width),
                      ),
                      topRight: Radius.circular(
                        SizeUtils.scale(
                            borderRadius ?? AppSize().borderRadiusSmall,
                            size.width),
                      ),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  errorStyle: errorStyle ?? AppFonts().bodyXSmallMedium,
                ),
                style: style ?? AppFonts().bodyMediumMedium,
                onChanged: (value) {
                  controller.formKey.currentState?.validate();
                  onChanged?.call(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '$label is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
