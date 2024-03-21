import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
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
    this.backgroundColor,
    this.hintStyle,
    this.dropDownBackgroundColor,
    this.borderColor,
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
  final Color? backgroundColor;
  final Color? dropDownBackgroundColor;
  final TextStyle? hintStyle;
  final Color? borderColor;

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
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              //To avoid long text overflowing.
              isExpanded: true,
              isDense: false,
              style: AppFonts.TitleXSmall.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              hint: Container(
                alignment: hintAlignment,
                child: MyText(
                  text: hint ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: hintStyle ??
                      AppFonts.TitleXSmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              value: value,
              items: dropdownItems,
              onChanged: onChanged,
              selectedItemBuilder: selectedItemBuilder,
              buttonStyleData: ButtonStyleData(
                padding: buttonPadding ??
                    EdgeInsets.only(
                      top: SizeUtils.scale(4.5, size.width),
                      bottom: SizeUtils.scale(4.5, size.width),
                      left: SizeUtils.scale(5.0, size.width),
                      right: SizeUtils.scale(12.0, size.width),
                    ),
                decoration: buttonDecoration ??
                    BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        SizeUtils.scale(
                            (borderRadius ?? AppSize().borderRadiusSmall),
                            size.width),
                      ),
                      border: Border.all(
                          color: borderColor ??
                              Theme.of(context).colorScheme.onBackground),
                    ),
                elevation: buttonElevation,
              ),
              iconStyleData: IconStyleData(
                icon: icon ??
                    SvgIcon(
                      icon: IconAssets.arrowDown,
                      height: SizeUtils.scale(iconSize ?? 18, size.width),
                    ),
                iconEnabledColor: iconEnabledColor,
                iconDisabledColor: iconDisabledColor,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: dropdownHeight ?? 200,
                isOverButton: false,
                useRootNavigator: false,
                decoration: dropdownDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      border: Border.all(
                        color: borderColor ??
                            Theme.of(context).colorScheme.onBackground,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeUtils.scale(
                            (AppSize().borderRadiusLarge), size.width),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
