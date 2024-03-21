import 'package:timesync/constants/font.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
  });

  final List<String> tabs;
  final TabController? controller;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeUtils.scale(20, size.width)),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        labelStyle: AppFonts.TitleSmall,
        unselectedLabelStyle: AppFonts.TitleSmall,
        unselectedLabelColor: Theme.of(context).colorScheme.outline,
        labelColor: Theme.of(context).colorScheme.onBackground,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: SizeUtils.scale(3, size.width),
            ),
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
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
