import 'package:get/get.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesync360/utils/logger.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    RxBool isDisableButton = false.obs;
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        width: width ?? double.infinity,
        height: height ?? size.height * 0.30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize().borderRadiusLarge * (size.width / 375.0),
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
              style: BodyLargeMedium,
            ),
            MyText(
              text: currentDate,
              style: BodyMediumRegular,
            ),
            SizedBox(height: size.height * 0.01),
            GestureDetector(
              onTap: isDisableButton.value == true
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
                  width: buttonSize ?? size.height * 0.16,
                  height: buttonSize ?? size.height * 0.16,
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
                      colors: isCheckedIn != null
                          ? isCheckedIn == true
                              ? [
                                  const Color(0XFFe83371),
                                  const Color(0XFF9b3092),
                                ]
                              : [
                                  const Color(0xFF4049E0),
                                  const Color(0XFF7653C9),
                                ]
                          : [
                              const Color.fromARGB(255, 122, 122, 122),
                              const Color.fromARGB(255, 122, 122, 122),
                            ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgAssets.tap,
                        width: iconSize ?? size.height * 0.05,
                        height: iconSize ?? size.height * 0.05,
                      ),
                      SizedBox(height: AppSize().paddingS4),
                      MyText(
                        text: isCheckedIn == true ? "Check Out" : "Check In",
                        style: BodyLargeMedium.copyWith(
                          color: Colors.white,
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
                  text: "Location: You are in office area.",
                  style: BodyMediumRegular,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
