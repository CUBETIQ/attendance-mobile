import 'package:flutter/material.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';

class EarnPointViewTablet extends StatelessWidget {
  const EarnPointViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(title: 'My Reward'),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
