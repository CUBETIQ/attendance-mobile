import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/profile/profile/model/option_model.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final Size size;
  final OptionModel option;

  const OptionButton({super.key, required this.size, required this.option});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: option.onTap,
      child: Container(
        width: size.width,
        height: SizeUtils.scale(55, size.width),
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
        ),
        margin: EdgeInsets.only(bottom: SizeUtils.scale(10, size.width)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.065),
        ),
        child: Row(
          children: [
            Icon(
              option.icon,
              color: Theme.of(context).colorScheme.primary,
              size: SizeUtils.scale(20, size.width),
            ),
            SizedBox(width: AppSize().paddingS8),
            MyText(
              text: option.title ?? "--------",
              style: AppFonts().bodyMedium,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
              size: SizeUtils.scale(16, size.width),
            ),
          ],
        ),
      ),
    );
  }
}
