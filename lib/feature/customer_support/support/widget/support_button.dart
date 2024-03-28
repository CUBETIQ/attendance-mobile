import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/customer_support/support/model/support_button.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({
    super.key,
    this.onTap,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    required this.buttonModel,
  });

  final void Function()? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final SupportButtonModel buttonModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        margin: margin,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          vertical: SizeUtils.scale(
            AppSize().paddingS10,
            size.width,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
          ),
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  buttonModel.leadingIcon,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: SizeUtils.scale(
                    AppSize().iconSizeLarge,
                    size.width,
                  ),
                ),
                SizedBox(
                  width: SizeUtils.scale(
                    AppSize().paddingS8,
                    size.width,
                  ),
                ),
                MyText(
                  text: buttonModel.title,
                  style: AppFonts().bodyMediumMedium.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                )
              ],
            ),
            Icon(
              buttonModel.trailingIcon,
              color: Theme.of(context).colorScheme.onPrimary,
              size: SizeUtils.scale(
                AppSize().iconSizeLarge,
                size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
