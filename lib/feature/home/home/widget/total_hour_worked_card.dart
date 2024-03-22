import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

class TotalHourWorkedCard extends StatelessWidget {
  const TotalHourWorkedCard({super.key, this.totalHourWorked});

  final String? totalHourWorked;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSize().borderRadiusMedium, size.width)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(16, size.width),
            vertical: SizeUtils.scale(12, size.width)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeUtils.scale(6, size.width)),
                  child: SvgIcon(
                      icon: IconAssets.task,
                      height: SizeUtils.scale(22, size.width),
                      width: SizeUtils.scale(22, size.width),
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                MyText(
                    text: "Total hour worked",
                    style: AppFonts.BodySmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
              ],
            ),
            MyText(
                text: totalHourWorked ?? "0 hrs 0 min",
                style: AppFonts.LabelMedium.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
          ],
        ),
      ),
    );
  }
}
