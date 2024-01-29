import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/color.dart';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/home/widget/record_data_card.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final int? checkInTime;
  final String? checkInStatus;
  final int? checkOutTime;
  final String? checkOutStatus;
  final double? width;
  final double? height;
  final DateTime date;
  final bool? isBreakTime;
  final String? breakTimeTitle;

  const RecordCard({
    super.key,
    this.width,
    this.height,
    this.checkInTime,
    this.checkOutTime,
    required this.date,
    this.checkInStatus,
    this.checkOutStatus,
    this.isBreakTime,
    this.breakTimeTitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width ?? double.infinity,
      height: height ?? size.width * 0.67,
      padding: EdgeInsets.all(SizeUtils.scale(AppSize.paddingS8, size.width)),
      margin: EdgeInsets.only(
        bottom: SizeUtils.scale(AppSize.paddingS8, size.width),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.borderRadiusMedium * (size.width / 375.0),
        ),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1.5,
            blurRadius: 1.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: DateFormatter().formatFullDate(date),
            style: BodyMediumSemi.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: AppSize.paddingS5 * (size.width / 375.0)),
          RecordDataCard(
            time: checkInTime,
            timeString:
                NavigationController.to.organization.value.configs?.startHour ??
                    "00:00",
            svgIcon: SvgAssets.checkIcon,
            firstTitle: "Actual check in",
            onNullTitle: "Check in time",
            secondTitle: "Check in",
            status: checkInStatus,
            iconColor: const Color(MyColor.success),
            icon: Icons.login,
          ),
          SizedBox(height: AppSize.paddingS5 * (size.width / 375.0)),
          RecordDataCard(
            time: null,
            timeString:
                NavigationController.to.organization.value.configs?.breakTime ??
                    "00:00",
            svgIcon: SvgAssets.location,
            firstTitle: "Lunch Break",
            onNullTitle: "Lunch Break",
            secondTitle: "Lunch Break",
            breakTimeTitle: breakTimeTitle,
            isBreakTime: isBreakTime,
            icon: Icons.coffee,
            iconColor: Colors.white,
            status: null,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4049E0),
                Color(0XFF7653C9),
              ],
            ),
          ),
          SizedBox(height: AppSize.paddingS5 * (size.width / 375.0)),
          RecordDataCard(
            time: checkOutTime,
            timeString:
                NavigationController.to.organization.value.configs?.endHour,
            svgIcon: SvgAssets.checkIcon,
            firstTitle: "Actual check in",
            onNullTitle: "Check out time",
            secondTitle: "Check out",
            icon: Icons.logout,
            iconColor: const Color(MyColor.error),
            status: checkOutStatus,
          ),
        ],
      ),
    );
  }
}
