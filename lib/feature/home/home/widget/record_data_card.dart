import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/home/home/widget/status_card.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              width: size.width * 0.045,
              height: size.width * 0.045,
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
                      fit: BoxFit.fill,
                    )
                  : isBreakTime == true
                      ? SvgPicture.asset(
                          svgIcon,
                          fit: BoxFit.fill,
                        )
                      : const SizedBox.shrink(),
            ),
            SizedBox(width: AppSize().paddingS8 * (size.width / 375.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: time != null
                      ? DateFormatter.formatTimeNoTrailing(
                          DateTime.fromMillisecondsSinceEpoch(
                          time ?? 0,
                        ))
                      : timeString ?? "--:--",
                  style: AppFonts().bodyMediumMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                SizedBox(height: AppSize().paddingS2),
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
          width: size.width * 0.40,
          height: size.width * 0.15,
          padding: EdgeInsets.symmetric(
            horizontal: AppSize().paddingHorizontalMedium,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSize().borderRadiusMedium * (size.width / 375.0),
              ),
              gradient: gradient ??
                  LinearGradient(
                    colors: [
                      Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.25),
                      Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.25),
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
                  SizedBox(height: AppSize().paddingS1),
                  StatusCard(
                    status: status,
                    isBreakTime: isBreakTime,
                    breakTimeTitle: breakTimeTitle,
                  ),
                ],
              ),
              Icon(
                icon,
                size: 20 * (size.width / 375.0),
                color: iconColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
