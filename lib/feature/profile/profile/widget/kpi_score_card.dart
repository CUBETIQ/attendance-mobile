import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:timesync360/utils/size_util.dart';
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
          height: SizeUtils.scaleMobile(50, size.width),
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scaleMobile(
              AppSize().paddingHorizontalMedium,
              size.width,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeUtils.scaleMobile(AppSize().borderRadiusLarge, size.width),
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
              SizedBox(width: SizeUtils.scaleMobile(10, size.width)),
              MyText(
                text: "${"Performance Score:".trString} $score",
                style: AppFonts().bodyLargeSemi.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          right: SizeUtils.scaleMobile(10, size.width),
          top: SizeUtils.scaleMobile(10, size.width),
          child: Icon(
            Icons.star_rounded,
            color: Colors.grey.darken(),
            size: SizeUtils.scaleMobile(25, size.width),
          ),
        ),
        Positioned(
          right: SizeUtils.scaleMobile(22, size.width),
          top: SizeUtils.scaleMobile(22, size.width),
          child: Icon(
            Icons.star_rounded,
            color: Colors.grey.darken(),
            size: SizeUtils.scaleMobile(48, size.width),
          ),
        ),
      ],
    );
  }
}
