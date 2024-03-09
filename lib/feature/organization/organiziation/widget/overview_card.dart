import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class OverViewCard extends StatelessWidget {
  const OverViewCard({
    super.key,
    this.staffs,
    this.totalStaff,
    this.totalDepartment,
    this.totalPosition,
  });

  final int? staffs;
  final int? totalStaff;
  final int? totalDepartment;
  final int? totalPosition;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      width: size.width,
      height: SizeUtils.scaleMobile(100, size.width),
      backgroundColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(
        SizeUtils.scaleMobile(14, size.width),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scaleMobile(24, size.width),
        vertical: SizeUtils.scaleMobile(16, size.width),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
                size: SizeUtils.scaleMobile(25, size.width),
              ),
              MyText(
                text: "Employee",
                style: AppFonts().bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              MyText(
                text: "${staffs ?? 0}/${totalStaff ?? 0}",
                style: AppFonts().bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.location_city_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
                size: SizeUtils.scaleMobile(25, size.width),
              ),
              MyText(
                text: "Department",
                style: AppFonts().bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              MyText(
                text: (totalDepartment ?? 0).toString(),
                style: AppFonts().bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.work_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
                size: SizeUtils.scaleMobile(25, size.width),
              ),
              MyText(
                text: "Position",
                style: AppFonts().bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              MyText(
                text: (totalPosition ?? 0).toString(),
                style: AppFonts().bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
