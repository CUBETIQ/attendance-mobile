import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key, this.value});

  final String? value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize().borderRadiusSmall),
          border: Border.all(color: Theme.of(context).colorScheme.primary)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(8, size.width),
            vertical: SizeUtils.scale(4, size.width)),
        child: MyText(
          text: value ?? '00',
          style: AppFonts.HeadlineMedium.copyWith(
              color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
