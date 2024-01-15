import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_util.dart';
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
        horizontal: SizeUtils.scale(
          AppSize.paddingHorizontalLarge,
          size.width,
        ),
        vertical: SizeUtils.scale(
          AppSize.paddingVerticalMedium,
          size.width,
        ),
      ),
      margin: EdgeInsets.only(
        bottom: SizeUtils.scale(
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
                width: SizeUtils.scale(40, size.width),
                height: SizeUtils.scale(40, size.width),
              ),
              SizedBox(width: SizeUtils.scale(15, size.width)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: SizeUtils.scale(210, size.width),
                    ),
                    child: MyText(
                      text: staff.firstName != null && staff.firstName != "" ||
                              staff.lastName != null && staff.lastName != ""
                          ? "${staff.firstName} ${staff.lastName}"
                          : staff.username ?? "N/A",
                      style: BodyMediumMedium,
                    ),
                  ),
                  MyText(
                    text: position.name ?? "N/A",
                    style: BodyMediumMedium,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SizeUtils.scale(10, size.width)),
          LinearPercentIndicator(
            animation: true,
            lineHeight: SizeUtils.scale(
              12,
              size.width,
            ),
            animationDuration: 500,
            padding: EdgeInsets.zero,
            percent: (percentage ?? 0) > 1 ? 1 : percentage ?? 0,
            barRadius: Radius.circular(
              SizeUtils.scale(
                AppSize.borderRadiusLarge,
                size.width,
              ),
            ),
            progressColor: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: SizeUtils.scale(10, size.width)),
          Row(
            children: [
              const MyText(text: "Total Hour: "),
              SizedBox(width: SizeUtils.scale(10, size.width)),
              MyText(
                text:
                    '${DateFormatter().formatMinutes(totalWorkMinute ?? 0)}/8:00',
              )
            ],
          )
        ],
      ),
    );
  }
}
