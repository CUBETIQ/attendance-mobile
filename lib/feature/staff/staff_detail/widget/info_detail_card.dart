import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class InfoDetailCard extends StatelessWidget {
  final String? title;
  final String? value;

  const InfoDetailCard({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: title ?? "Title",
          style: BodySmallMedium.copyWith(
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
              AppSize.paddingHorizontalLarge,
              size.width,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeUtils.scale(AppSize.borderRadiusLarge, size.width),
            ),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
          ),
          alignment: Alignment.centerLeft,
          child: MyText(
            text: value.capitalizeMaybeNull ?? "N/A",
            style: BodyLargeRegular,
          ),
        ),
      ],
    );
  }
}
