import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MyDropDownButton<T> extends StatelessWidget {
  const MyDropDownButton({
    this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    this.borderRadius,
    this.hasLabel = true,
    this.labelStyle,
    required this.label,
    super.key,
    this.width,
    this.height,
    this.isRoundedCorner = false,
    this.backgroundColor,
    this.hintStyle,
    this.dropDownBackgroundColor,
  });

  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>>? dropdownItems;
  final ValueChanged<T?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final double? borderRadius;
  final bool? hasLabel;
  final TextStyle? labelStyle;
  final String label;
  final double? width;
  final double? height;
  final bool isRoundedCorner;
  final Color? backgroundColor;
  final Color? dropDownBackgroundColor;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hasLabel == false
            ? const SizedBox.shrink()
            : MyText(
                text: label,
                style: labelStyle ?? AppFonts().bodyMediumMedium,
              ),
        const SizedBox(height: 8),
        SizedBox(
          width: width ?? double.infinity,
          height: height ??
              SizeUtils.scale(size.width < 600 ? 47.7 : 51, size.width),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              //To avoid long text overflowing.
              isExpanded: true,
              style: AppFonts().bodyMediumMedium.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              hint: Container(
                alignment: hintAlignment,
                child: MyText(
                  text: hint ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: hintStyle ?? AppFonts().bodyMediumMedium,
                ),
              ),
              value: value,
              items: dropdownItems,
              onChanged: onChanged,
              selectedItemBuilder: selectedItemBuilder,
              buttonStyleData: ButtonStyleData(
                height: buttonHeight ?? double.infinity,
                width: buttonWidth ?? 60,
                padding: buttonPadding ??
                    EdgeInsets.symmetric(
                      horizontal: SizeUtils.scale(30.0, size.width),
                    ),
                decoration: buttonDecoration ??
                    BoxDecoration(
                      color: backgroundColor ??
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.095),
                      borderRadius: isRoundedCorner == true
                          ? BorderRadius.circular(
                              SizeUtils.scale(
                                  (borderRadius ?? AppSize().borderRadiusLarge),
                                  size.width),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(
                                SizeUtils.scale(
                                    (borderRadius ??
                                        AppSize().borderRadiusLarge),
                                    size.width),
                              ),
                              topRight: Radius.circular(
                                SizeUtils.scale(
                                    (borderRadius ??
                                        AppSize().borderRadiusLarge),
                                    size.width),
                              ),
                            ),
                      border: Border(
                        bottom: isRoundedCorner == true
                            ? BorderSide.none
                            : BorderSide(
                                width: 1.5,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.9),
                              ),
                      ),
                    ),
                elevation: buttonElevation,
              ),
              iconStyleData: IconStyleData(
                icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
                iconSize: SizeUtils.scale(iconSize ?? 14, size.width),
                iconEnabledColor: iconEnabledColor,
                iconDisabledColor: iconDisabledColor,
              ),
              dropdownStyleData: DropdownStyleData(
                //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
                maxHeight: dropdownHeight ?? 200,
                isOverButton: false,
                useRootNavigator: false,
                padding: dropdownPadding ??
                    EdgeInsets.symmetric(
                      horizontal: SizeUtils.scale(
                        AppSize().paddingHorizontalLarge,
                        size.width,
                      ),
                      vertical: SizeUtils.scale(
                        AppSize().paddingVerticalMedium,
                        size.width,
                      ),
                    ),
                decoration: dropdownDecoration ??
                    BoxDecoration(
                      color: dropDownBackgroundColor ??
                          Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(
                        AppSize().borderRadiusLarge * (size.width / 375.0),
                      ),
                    ),
                elevation: dropdownElevation ?? 2,
                //Null or Offset(0, 0) will open just under the button. You can edit as you want.
                offset: offset,
                scrollbarTheme: ScrollbarThemeData(
                  radius: scrollbarRadius ?? const Radius.circular(40),
                  thickness: scrollbarThickness != null
                      ? MaterialStateProperty.all<double>(scrollbarThickness!)
                      : null,
                  thumbVisibility: scrollbarAlwaysShow != null
                      ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                      : null,
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: itemHeight ?? 40,
                padding:
                    itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
