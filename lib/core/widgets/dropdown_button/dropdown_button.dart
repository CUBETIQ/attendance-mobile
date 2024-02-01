import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
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
                style: labelStyle ?? BodyMediumMedium,
              ),
        const SizedBox(height: 8),
        SizedBox(
          width: width ?? double.infinity,
          height: height ?? SizeUtils.scale(47.7, size.width),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              //To avoid long text overflowing.
              isExpanded: true,
              style: BodyMediumMedium.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              hint: Container(
                alignment: hintAlignment,
                child: MyText(
                  text: hint ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: BodyMediumMedium,
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
                      horizontal: (AppSize.paddingS17) * (size.width / 375.0),
                    ),
                decoration: buttonDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: isRoundedCorner == true
                          ? BorderRadius.circular(
                              (borderRadius ?? AppSize.borderRadiusLarge) *
                                  (size.width / 375.0),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(
                                (borderRadius ?? AppSize.borderRadiusSmall) *
                                    (size.width / 375.0),
                              ),
                              topRight: Radius.circular(
                                (borderRadius ?? AppSize.borderRadiusSmall) *
                                    (size.width / 375.0),
                              ),
                            ),
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 1.0,
                        ),
                      ),
                    ),
                elevation: buttonElevation,
              ),
              iconStyleData: IconStyleData(
                icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
                iconSize: (iconSize ?? 14) * (size.width / 375.0),
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
                        AppSize.paddingHorizontalLarge,
                        size.width,
                      ),
                      vertical: SizeUtils.scale(
                        AppSize.paddingVerticalMedium,
                        size.width,
                      ),
                    ),
                decoration: dropdownDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(
                        AppSize.borderRadiusLarge * (size.width / 375.0),
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
