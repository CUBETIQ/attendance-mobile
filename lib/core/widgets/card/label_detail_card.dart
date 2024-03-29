import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class LabelDetailCard extends StatelessWidget {
  final String? title;
  final String? value;

  const LabelDetailCard({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: title ?? "Title",
          style: AppFonts().bodySmallMedium.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        Container(
          width: double.infinity,
          height: SizeUtils.scale(50, size.width),
          margin: EdgeInsets.only(
            top: SizeUtils.scale(10, size.width),
            bottom: SizeUtils.scale(15, size.width),
          ),
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
            color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
          ),
          alignment: Alignment.centerLeft,
          child: MyText(
            text: value != null && value != ""
                ? value.capitalizeMaybeNull ?? "-"
                : "-",
            style: AppFonts().bodyLargeRegular,
          ),
        ),
      ],
    );
  }
}
