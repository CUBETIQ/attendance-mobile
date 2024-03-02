import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class LabelDescriptionCard extends StatelessWidget {
  final String? title;
  final String? value;

  const LabelDescriptionCard({super.key, this.title, this.value});

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
          height: value != null && (value?.length ?? 0) < 200
              ? SizeUtils.scaleMobile(150, size.width)
              : null,
          margin: EdgeInsets.only(
            top: SizeUtils.scaleMobile(10, size.width),
            bottom: SizeUtils.scaleMobile(15, size.width),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scaleMobile(
              AppSize().paddingHorizontalLarge,
              size.width,
            ),
            vertical: SizeUtils.scaleMobile(
              AppSize().paddingVerticalMedium,
              size.width,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeUtils.scaleMobile(AppSize().borderRadiusLarge, size.width),
            ),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
          ),
          alignment: Alignment.topLeft,
          child: MyText(
            text: value != null && value != ""
                ? value.capitalizeMaybeNull ?? "N/A"
                : "N/A",
            style: AppFonts().bodyLargeRegular,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
