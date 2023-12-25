import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class KpiScoreCard extends StatelessWidget {
  final String score;

  const KpiScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width - 48,
          height: SizeUtils.scaleWidth(50, size.width),
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scaleWidth(
              AppSize.paddingHorizontalMedium,
              size.width,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeUtils.scaleWidth(AppSize.borderRadiusLarge, size.width),
            ),
            color: Theme.of(context).colorScheme.outline.darken(),
          ),
          child: Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.white,
                size: size.width * 0.1,
              ),
              SizedBox(width: SizeUtils.scaleWidth(10, size.width)),
              MyText(
                text: "Performance Score: $score",
                style: BodyLargeSemi.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: SizeUtils.scaleWidth(10, size.width),
          top: SizeUtils.scaleWidth(10, size.width),
          child: Icon(
            Icons.star_rounded,
            color: Colors.grey.darken(),
            size: SizeUtils.scaleWidth(25, size.width),
          ),
        ),
        Positioned(
          right: SizeUtils.scaleWidth(22, size.width),
          top: SizeUtils.scaleWidth(22, size.width),
          child: Icon(
            Icons.star_rounded,
            color: Colors.grey.darken(),
            size: SizeUtils.scaleWidth(48, size.width),
          ),
        ),
      ],
    );
  }
}
