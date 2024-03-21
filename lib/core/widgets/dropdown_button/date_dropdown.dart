import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:flutter/material.dart';

class DateDropDown extends StatelessWidget {
  const DateDropDown({
    super.key,
    required this.date,
    required this.size,
    this.onTap,
    this.isShowday = true,
    this.width,
    this.height,
  });

  final DateTime date;
  final Size size;
  final void Function()? onTap;
  final bool isShowday;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(12, size.width),
          vertical: SizeUtils.scale(10, size.width),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(100, size.width),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: isShowday == true
                  ? DateUtil.formatShortDate(date)
                  : DateUtil.formatShortDateWithoutDay(date),
              style: AppFonts.TitleXSmall.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            SizedBox(
              width: SizeUtils.scale(
                AppSize().paddingS1,
                size.width,
              ),
            ),
            SvgIcon(
                icon: IconAssets.arrowDown,
                height: SizeUtils.scale(18, size.width),
                width: SizeUtils.scale(18, size.width),
                color: Theme.of(context).colorScheme.onBackground),
          ],
        ),
      ),
    );
  }
}
