import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/utils/size_util.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({
    super.key,
    this.width,
    this.height,
    required this.currentIndex,
    required this.values,
    required this.selectedIndex,
    required this.icons,
    this.onChanged,
  });

  final double? width;
  final double? height;
  final int currentIndex;
  final List<int> values;
  final int selectedIndex;
  final List<IconData> icons;
  final Function(int)? onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: SizeUtils.scale(50, size.width),
      child: AnimatedToggleSwitch<int>.size(
        textDirection: TextDirection.rtl,
        current: currentIndex,
        values: values,
        indicatorSize: Size.fromWidth(SizeUtils.scale(200, size.width)),
        selectedIconScale: 1,
        indicatorAppearingBuilder: (context, value, indicator) {
          return Container(
            height: SizeUtils.scale(50, size.width),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(
                SizeUtils.scale(
                  AppSize().borderRadiusLarge,
                  size.width,
                ),
              ),
            ),
          );
        },
        iconBuilder: (i) => Icon(icons[i],
            color: selectedIndex == i
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            size: SizeUtils.scale(
              22,
              size.width,
            )),
        iconOpacity: 0.8,
        iconAnimationType: AnimationType.onSelected,
        style: ToggleStyle(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(
              AppSize().borderRadiusLarge,
              size.width,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0.2,
              blurRadius: 0.2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        styleBuilder: (i) => ToggleStyle(
          indicatorColor: Theme.of(context).colorScheme.primary,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
