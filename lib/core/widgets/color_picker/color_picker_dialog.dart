import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getColorPickerDialog({
  required BuildContext context,
  Color screenPickerColor = Colors.blue,
  void Function(String?, Color?)? onChangeResult,
  void Function()? onCancel,
  void Function()? onConfirm,
}) {
  Color? color;
  String? stringColor;
  Get.dialog(
    Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize.paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSize.borderRadiusLarge *
                    (MediaQuery.of(context).size.width / 375.0),
              ),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ColorPicker(
                  // Use the screenPickerColor as start color.
                  color: screenPickerColor,
                  // Update the screenPickerColor using the callback.
                  onColorChanged: (Color value) {
                    color = value;
                    String? colorString = value.toString();
                    RegExp regExp = RegExp(r'0x([0-9a-fA-F]+)');
                    Match? match = regExp.firstMatch(colorString);
                    // Extract the color value
                    stringColor = match?.group(0) ?? '';
                    onChangeResult?.call(stringColor, color);
                  },
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: true,
                    ColorPickerType.custom: true,
                    ColorPickerType.wheel: false,
                    ColorPickerType.primary: false,
                    ColorPickerType.accent: false,
                    ColorPickerType.bw: false,
                  },
                  heading: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSize.paddingS8),
                    child: MyText(
                      text: 'Select color',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  subheading: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSize.paddingS8),
                    child: MyText(
                      text: 'Select color shade',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.scale(
                      AppSize.paddingHorizontalLarge,
                      MediaQuery.of(context).size.width,
                    ),
                    vertical: AppSize.paddingS4,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: onCancel,
                          child: MyText(
                            text: 'Cancel',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: onConfirm,
                          child: MyText(
                            text: 'Select',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
