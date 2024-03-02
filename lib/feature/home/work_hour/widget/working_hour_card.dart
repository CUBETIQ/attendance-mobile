import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WorkHourCard extends StatelessWidget {
  const WorkHourCard({
    super.key,
    required this.staff,
    required this.position,
    this.percentage,
    this.totalWorkMinute,
  });

  final UserModel staff;
  final PositionModel position;
  final double? percentage;
  final int? totalWorkMinute;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
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
      margin: EdgeInsets.only(
        bottom: SizeUtils.scaleMobile(
          10,
          size.width,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              MyCacheImage(
                imageUrl: staff.image,
                width: SizeUtils.scaleMobile(40, size.width),
                height: SizeUtils.scaleMobile(40, size.width),
              ),
              SizedBox(width: SizeUtils.scaleMobile(15, size.width)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: SizeUtils.scaleMobile(210, size.width),
                    ),
                    child: MyText(
                      text: StringUtil.getfullname(
                        staff.firstName,
                        staff.lastName,
                        staff.username,
                      ),
                      style: AppFonts().bodyMediumMedium,
                    ),
                  ),
                  MyText(
                    text: position.name ?? "N/A",
                    style: AppFonts().bodyMediumMedium,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
          LinearPercentIndicator(
            animation: true,
            lineHeight: SizeUtils.scaleMobile(
              12,
              size.width,
            ),
            animationDuration: 500,
            padding: EdgeInsets.zero,
            percent: (percentage ?? 0) > 1 ? 1 : percentage ?? 0,
            barRadius: Radius.circular(
              SizeUtils.scaleMobile(
                AppSize().borderRadiusLarge,
                size.width,
              ),
            ),
            progressColor: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
          Row(
            children: [
              const MyText(text: "Total Hour:"),
              MyText(
                text:
                    ' ${DateFormatter.formatMinutes(totalWorkMinute ?? 0)}/8:00',
              )
            ],
          )
        ],
      ),
    );
  }
}
