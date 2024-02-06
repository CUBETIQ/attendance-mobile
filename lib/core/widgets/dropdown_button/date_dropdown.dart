import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:flutter/material.dart';

class DateDropDown extends StatelessWidget {
  const DateDropDown({
    super.key,
    required this.date,
    required this.size,
    this.onTap,
    this.isShowday = true,
  });

  final DateTime date;
  final Size size;
  final void Function()? onTap;
  final bool isShowday;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize().paddingS5,
            size.width,
          ),
          vertical: SizeUtils.scale(
            AppSize().paddingS2,
            size.width,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(
              AppSize().borderRadiusLarge,
              size.width,
            ),
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          children: [
            MyText(
              text: isShowday == true
                  ? DateFormatter().formatShortDate(date)
                  : DateFormatter().formatShortDateWithoutDay(date),
              style: BodySmall.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(
              width: SizeUtils.scale(
                AppSize().paddingS1,
                size.width,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
