import 'package:flutter/material.dart';
import 'package:timesync/constants/app_shadow.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/progress_indicator/linear_progress_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

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
        horizontal: SizeUtils.scale(16, size.width),
        vertical: SizeUtils.scale(12, size.width),
      ),
      borderRadius: BorderRadius.circular(
        SizeUtils.scale(AppSpacing.L, size.width),
      ),
      boxShadow: [AppShadow.shadowWithoutColor],
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: SizeUtils.scale(16, size.width)),
                child: MyCacheImage(
                  imageUrl: staff.image,
                  width: SizeUtils.scale(40, size.width),
                  height: SizeUtils.scale(40, size.width),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: StringUtil.getfullname(
                        staff.firstName,
                        staff.lastName,
                        staff.username,
                      ),
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.TitleSmall.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeUtils.scale(2, size.width)),
                      child: MyText(
                          text: position.name ?? "-",
                          style: AppFonts.LabelSmall.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeUtils.scale(12, size.width)),
            child: MyLinearProgressIndicator(
              percent: (percentage ?? 0) > 1 ? 1 : percentage ?? 0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                  text: "Total worked hours",
                  style: AppFonts.LabelSmall.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              MyText(
                text:
                    ' ${DateUtil().formatTotalWorkMinute(totalWorkMinute ?? 0)}',
                style: AppFonts.LabelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              )
            ],
          )
        ],
      ),
    );
  }
}
