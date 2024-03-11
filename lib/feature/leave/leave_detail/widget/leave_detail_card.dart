import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class LeaveDetailCard extends StatelessWidget {
  final String? title;
  final String? value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final bool? noDivider;
  final Widget? child;

  const LeaveDetailCard({
    super.key,
    this.title,
    this.value,
    this.titleStyle,
    this.valueStyle,
    this.noDivider,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeUtils.scale(AppSize().paddingS5, size.width),
        ),
        MyText(
          text: title ?? "Title",
          style: titleStyle ??
              AppFonts().bodyMediumRegular.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
        ),
        SizedBox(
          height: SizeUtils.scale(AppSize().paddingS5, size.width),
        ),
        child ??
            MyText(
              text: value ?? "value",
              style: valueStyle ?? AppFonts().bodyLargeMedium,
            ),
        noDivider == true ? const SizedBox.shrink() : const Divider(),
      ],
    );
  }
}
