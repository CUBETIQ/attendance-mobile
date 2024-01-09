import 'package:attendance_app/config/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({super.key, required this.tabs, this.controller});

  final List<String> tabs;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: TabBar(
        controller: controller,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        labelStyle: BodyLargeMedium,
        unselectedLabelStyle: BodyLargeMedium,
        unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
        labelColor: Theme.of(context).colorScheme.onBackground,
        dividerColor: Colors.transparent,
        tabs: [
          ...List.generate(
            tabs.length,
            (index) => Tab(
              text: tabs[index].tr,
            ),
          ),
        ],
      ),
    );
  }
}
