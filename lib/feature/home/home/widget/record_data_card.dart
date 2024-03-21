import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/home/home/widget/status_card.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesync/utils/size_util.dart';

class RecordDataCard extends StatelessWidget {
  final int? time;
  final String? timeString;
  final String svgIcon;
  final String firstTitle;
  final String onNullTitle;
  final String secondTitle;
  final String? status;
  final IconData? icon;
  final Color? iconColor;
  final bool? noStatus;
  final Gradient? gradient;
  final bool? isBreakTime;
  final String? breakTimeTitle;

  const RecordDataCard({
    super.key,
    this.time,
    required this.svgIcon,
    required this.firstTitle,
    required this.onNullTitle,
    required this.secondTitle,
    this.status,
    this.timeString,
    this.icon,
    this.iconColor,
    this.noStatus,
    this.gradient,
    this.isBreakTime,
    this.breakTimeTitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: SizeUtils.scale(20, size.width),
              height: SizeUtils.scale(20, size.width),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: time != null
                  ? SvgPicture.asset(
                      svgIcon,
                      width: SizeUtils.scale(20, size.width),
                      height: SizeUtils.scale(20, size.width),
                    )
                  : isBreakTime == true
                      ? SvgPicture.asset(
                          svgIcon,
                          width: SizeUtils.scale(20, size.width),
                          height: SizeUtils.scale(20, size.width),
                        )
                      : const SizedBox.shrink(),
            ),
            SizedBox(width: SizeUtils.scale(AppSize().paddingS8, size.width)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: time != null
                      ? DateUtil.formatTimeNoTrailing(
                          DateTime.fromMillisecondsSinceEpoch(
                          time ?? 0,
                        ))
                      : timeString ?? "--:--",
                  style: AppFonts().bodyMediumMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS2, size.width),
                ),
                MyText(
                  text: time != null ? secondTitle : onNullTitle,
                  style: AppFonts().bodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: SizeUtils.scale(160, size.width),
          height: SizeUtils.scale(75, size.width),
          padding: EdgeInsets.symmetric(
            horizontal: AppSize().paddingHorizontalMedium,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                SizeUtils.scale(AppSize().borderRadiusMedium, size.width),
              ),
              gradient: gradient ??
                  LinearGradient(
                    colors: [
                      Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.20),
                      Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.20),
                    ],
                  )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: secondTitle,
                    style: AppFonts().bodyMediumMedium.copyWith(
                          color: gradient != null
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  SizedBox(
                    height: SizeUtils.scale(AppSize().paddingS1, size.width),
                  ),
                  StatusCard(
                    status: status,
                    isBreakTime: isBreakTime,
                    breakTimeTitle: breakTimeTitle,
                  ),
                ],
              ),
              Icon(
                icon,
                size: SizeUtils.scale(20, size.width),
                color: iconColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
