import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttendanceCard extends StatelessWidget {
  final bool? isCheckedIn;
  final String currentDate;
  final Function()? onCheckIn;
  final Function()? onCheckOut;
  final Animation<double> scale;
  final double? height;
  final double? width;
  final double? buttonSize;
  final double? iconSize;

  const AttendanceCard({
    super.key,
    this.isCheckedIn,
    required this.currentDate,
    this.onCheckIn,
    this.onCheckOut,
    required this.scale,
    this.height,
    this.width,
    this.buttonSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width ?? double.infinity,
      height: height ?? size.height * 0.30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.borderRadiusLarge * (size.width / 375.0),
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
            onTap: isCheckedIn != null
                ? isCheckedIn == true
                    ? onCheckOut
                    : onCheckIn
                : null,
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
                      tap,
                      width: iconSize ?? size.height * 0.05,
                      height: iconSize ?? size.height * 0.05,
                    ),
                    const SizedBox(height: AppSize.paddingS4),
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
    );
  }
}
