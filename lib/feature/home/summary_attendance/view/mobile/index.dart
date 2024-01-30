import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/summary_attendance/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class SummaryAttendaceViewMobile extends StatelessWidget {
  const SummaryAttendaceViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = SummaryAttendanceController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Summary",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize.paddingHorizontalLarge,
              size.width,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeUtils.scale(30, size.width)),
              MyText(text: "Present", style: BodyLargeMedium),
              SizedBox(height: SizeUtils.scale(15, size.width)),
              ListView.separated(
                itemCount: controller.staffAttendanceList.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeUtils.scale(10, size.width),
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => MyCard(
                  width: size.width,
                  height: SizeUtils.scale(60, size.width),
                  child: Row(
                    children: [],
                  ),
                ),
              ),
              MyText(text: "Leave", style: BodyLargeMedium),
              MyText(text: "Absent", style: BodyLargeMedium),
            ],
          ),
        ),
      ),
    );
  }
}
