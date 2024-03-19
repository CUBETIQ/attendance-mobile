import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesync/utils/logger.dart';
import 'package:timesync/utils/size_util.dart';

class AttendanceCard extends StatelessWidget {
  final bool? isCheckedIn;
  final String currentDate;
  final Future<void> Function() onCheckIn;
  final Future<void> Function() onCheckOut;
  final Animation<double> scale;
  final double? height;
  final double? width;
  final double? buttonSize;
  final double? iconSize;
  final bool isInOfficeRange;
  final bool disableButton;

  const AttendanceCard({
    super.key,
    this.isCheckedIn,
    required this.currentDate,
    required this.onCheckIn,
    required this.onCheckOut,
    required this.scale,
    this.height,
    this.width,
    this.buttonSize,
    this.iconSize,
    this.isInOfficeRange = false,
    this.disableButton = false,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isDisableButton = false.obs;
    final size = MediaQuery.of(context).size;
    return Container(
      width: width ?? double.infinity,
      height: height ?? SizeUtils.scale(280, size.width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
        ),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.17),
            spreadRadius: 1.2,
            blurRadius: 1.2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            text: "Today's Date",
            style: AppFonts().bodyLargeMedium,
          ),
          MyText(
            text: currentDate,
            style: AppFonts().bodyMediumRegular,
          ),
          SizedBox(height: SizeUtils.scale(20, size.width)),
          GestureDetector(
            onTap: disableButton
                ? null
                : isDisableButton.value == true
                    ? null
                    : isCheckedIn == true
                        ? () async {
                            try {
                              isDisableButton.value = true;
                              await onCheckOut();
                            } catch (e) {
                              Logs.e(e);
                              return;
                            } finally {
                              isDisableButton.value = false;
                            }
                          }
                        : () async {
                            try {
                              isDisableButton.value = true;
                              await onCheckIn();
                            } catch (e) {
                              Logs.e(e);
                              return;
                            } finally {
                              isDisableButton.value = false;
                            }
                          },
            child: ScaleTransition(
              scale: scale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: buttonSize ?? SizeUtils.scale(130, size.width),
                height: buttonSize ?? SizeUtils.scale(130, size.width),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: disableButton
                        ? [
                            Theme.of(context).colorScheme.outline,
                            Theme.of(context).colorScheme.outline,
                          ]
                        : isCheckedIn != null
                            ? isCheckedIn == true
                                ? [
                                    const Color(0XFFe83371),
                                    const Color(0XFF9b3092),
                                  ]
                                : Get.isDarkMode
                                    ? [
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .darken(12),
                                      ]
                                    : [
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .lighten(12),
                                      ]
                            : [
                                const Color.fromARGB(255, 122, 122, 122),
                                const Color.fromARGB(255, 122, 122, 122),
                              ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SvgAssets.tap,
                      width: iconSize ?? size.height * 0.05,
                      height: iconSize ?? size.height * 0.05,
                      colorFilter: ColorFilter.mode(
                        isCheckedIn == true && Get.isDarkMode
                            ? Colors.white
                            : Theme.of(context).colorScheme.onPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: AppSize().paddingS4),
                    MyText(
                      text: isCheckedIn == true ? "Check Out" : "Check In",
                      style: AppFonts().bodyLargeMedium.copyWith(
                            color: isCheckedIn == true && Get.isDarkMode
                                ? Colors.white
                                : Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: size.width * 0.01),
              MyText(
                text: isInOfficeRange
                    ? "Location: You are in office area."
                    : "Location: You are not in office area.",
                style: AppFonts().bodyMediumRegular,
              ),
            ],
          )
        ],
      ),
    );
  }
}
