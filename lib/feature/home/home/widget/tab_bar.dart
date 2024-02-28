import 'package:timesync360/constants/font.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.isCircleBorder = false,
  });

  final List<String> tabs;
  final TabController? controller;
  final bool? isCircleBorder;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: isCircleBorder == true
            ? BorderRadius.circular(
                SizeUtils.scale(15, size.width),
              )
            : null,
      ),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        labelStyle: AppStyles().bodyLargeMedium,
        unselectedLabelStyle: AppStyles().bodyLargeMedium,
        unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
        labelColor: isCircleBorder == true
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onBackground,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          borderRadius: isCircleBorder == true
              ? BorderRadius.circular(
                  SizeUtils.scale(15, size.width),
                )
              : null,
          color: isCircleBorder == true
              ? Theme.of(context).colorScheme.primary
              : null,
          border: isCircleBorder == true
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: SizeUtils.scale(3, size.width),
                  ),
                ),
        ),
        indicatorSize: isCircleBorder == true
            ? TabBarIndicatorSize.tab
            : TabBarIndicatorSize.label,
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
