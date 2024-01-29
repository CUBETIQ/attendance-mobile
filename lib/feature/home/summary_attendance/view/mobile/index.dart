import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:flutter/material.dart';

class SummaryAttendaceViewMobile extends StatelessWidget {
  const SummaryAttendaceViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
