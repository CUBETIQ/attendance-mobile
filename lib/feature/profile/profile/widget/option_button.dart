import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/profile/profile/model/option_model.dart';
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
        height: size.width * 0.15,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingHorizontalLarge,
        ),
        margin: const EdgeInsets.only(
          bottom: AppSize.paddingS5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.borderRadiusLarge * (size.width / 375),
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.065),
        ),
        child: Row(
          children: [
            Icon(
              option.icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20 * (size.width / 375),
            ),
            const SizedBox(width: AppSize.paddingS8),
            MyText(
              text: option.title ?? "--------",
              style: BodyMedium,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
              size: 16 * (size.width / 375),
            ),
          ],
        ),
      ),
    );
  }
}