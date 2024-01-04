import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttendancePieChartCard extends StatelessWidget {
  const AttendancePieChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: SizeUtils.scale(150, size.width),
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(AppSize.paddingS1, size.width),
        vertical: SizeUtils.scale(AppSize.paddingVerticalMedium, size.width),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize.borderRadiusLarge, size.width),
        ),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: SizeUtils.scale(150, size.width),
            height: SizeUtils.scale(150, size.width),
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    showTitle: false,
                    color: Colors.grey,
                    value: 1,
                    title: "Present",
                    radius: 100,
                    titleStyle: BodyMediumRegular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              swapAnimationDuration: const Duration(milliseconds: 150),
              swapAnimationCurve: Curves.linear,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: SizeUtils.scale(12, size.width),
                    height: SizeUtils.scale(12, size.width),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(
                        SizeUtils.scale(10, size.width),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(10, size.width)),
                  MyText(
                    text: "Present: 10",
                    style: BodyMediumRegular,
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              Row(
                children: [
                  Container(
                    width: SizeUtils.scale(12, size.width),
                    height: SizeUtils.scale(12, size.width),
                    decoration: BoxDecoration(
                      color: const Color(0XFFBF9705),
                      borderRadius: BorderRadius.circular(
                        SizeUtils.scale(10, size.width),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(10, size.width)),
                  MyText(
                    text: "On Leave: 1",
                    style: BodyMediumRegular,
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              Row(
                children: [
                  Container(
                    width: SizeUtils.scale(12, size.width),
                    height: SizeUtils.scale(12, size.width),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        SizeUtils.scale(10, size.width),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(10, size.width)),
                  MyText(
                    text: "Absent: 0",
                    style: BodyMediumRegular,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
