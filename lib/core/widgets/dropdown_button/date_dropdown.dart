import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:flutter/material.dart';

class DateDropDown extends StatelessWidget {
  const DateDropDown({
    super.key,
    required this.date,
    required this.size,
    this.onTap,
  });

  final DateTime date;
  final Size size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize.paddingS5,
            size.width,
          ),
          vertical: SizeUtils.scale(
            AppSize.paddingS2,
            size.width,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(
              AppSize.borderRadiusLarge,
              size.width,
            ),
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          children: [
            MyText(
              text: DateFormatter().formatShortDate(date),
              style: BodySmall.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(
              width: SizeUtils.scale(
                AppSize.paddingS1,
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
