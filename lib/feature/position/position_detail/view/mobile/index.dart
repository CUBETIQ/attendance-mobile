import 'package:flutter/material.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/feature/position/position_detail/controller/index.dart';

class PositionDetailViewMobile extends StatelessWidget {
  const PositionDetailViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PositionDetailController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Position Detail",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
