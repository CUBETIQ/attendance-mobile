import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/feature/home/home/widget/record_data_card.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize().borderRadiusMedium, size.width),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeUtils.scale(16, size.width)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: SizeUtils.scale(10, size.width)),
              child: MyText(
                text: DateUtil.formatFullDate(date),
                style: AppFonts.LabelMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Column(
              children: [
                RecordDataCard(
                  time: checkInTime,
                  timeString: NavigationController
                          .to.organization.value.configs?.startHour ??
                      "00:00",
                  svgIcon: IconAssets.loginTwoTone,
                  statusTitle: "Check-In",
                  onNullTitle: "Check-in Schedule",
                  secondTitle: "Checked-in",
                  status: checkInStatus,
                  iconColor: const Color(0xFF198754),
                ),
                RecordDataCard(
                  time: null,
                  timeString: NavigationController
                          .to.organization.value.configs?.breakTime ??
                      "00:00",
                  svgIcon: IconAssets.noodle,
                  statusTitle: "Lunch Break",
                  onNullTitle: "Lunch Break",
                  secondTitle: "Lunch Break",
                  breakTimeTitle: breakTimeTitle,
                  isBreakTime: isBreakTime,
                  iconColor: Colors.white,
                  status: null,
                ),
                const RecordDataCard(
                  time: null,
                  svgIcon: IconAssets.charger,
                  statusTitle: "After Break",
                  onNullTitle: "After Break",
                  secondTitle: "After Break",
                ),
                RecordDataCard(
                  time: checkOutTime,
                  timeString: NavigationController
                      .to.organization.value.configs?.endHour,
                  svgIcon: IconAssets.logoutTwoTone,
                  statusTitle: "Check-Out",
                  onNullTitle: "Check-out Schedule",
                  secondTitle: "Checked-out",
                  iconColor: Theme.of(context).colorScheme.error,
                  status: checkOutStatus,
                  isCheckOut: true,
                ),
              ].withSpaceBetween(height: SizeUtils.scale(10, size.width)),
            ),
          ],
        ),
      ),
    );
  }
}
