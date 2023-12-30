import 'package:flutter/material.dart';
import '../../../../../core/widgets/button/back_button.dart';
import '../../../../../core/widgets/text/app_bar_title.dart';

class LeaveDetailViewMobile extends StatelessWidget {
  const LeaveDetailViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Leave Detail",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
