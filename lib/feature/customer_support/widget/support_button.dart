import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/customer_support/model/support_button.dart';
import 'package:timesync360/utils/size_util.dart';
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
        height: height ?? 48 * (size.width / 375.0),
        margin: margin,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
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
                ),
                SizedBox(
                  width: SizeUtils.scale(
                    AppSize().paddingS8,
                    size.width,
                  ),
                ),
                MyText(
                  text: buttonModel.title,
                  style: AppStyles().bodyMediumMedium.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                )
              ],
            ),
            Icon(
              buttonModel.trailingIcon,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          ],
        ),
      ),
    );
  }
}
