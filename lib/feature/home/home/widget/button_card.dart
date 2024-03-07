import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeUtils.scaleMobile(150, size.width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scaleMobile(
              AppSize().borderRadiusLarge,
              size.width,
            ),
          ),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1.5,
              blurRadius: 1.5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(SizeUtils.scaleMobile(10, size.width)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                icon,
                size: SizeUtils.scaleMobile(40, size.width),
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            SizedBox(
              height: SizeUtils.scaleMobile(10, size.width),
            ),
            MyText(
              text: title,
              style: AppFonts().bodyLargeMedium,
            )
          ],
        ),
      ),
    );
  }
}
