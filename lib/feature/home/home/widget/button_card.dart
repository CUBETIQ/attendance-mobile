import 'package:flutter/material.dart';
import 'package:timesync/constants/app_shadow.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    required this.title,
    required this.svgIcon,
    required this.color,
    this.onTap,
  });

  final String title;
  final String svgIcon;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeUtils.scale(138, size.width),
        width: SizeUtils.scale(152, size.width),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSpacing.L, size.width),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(SizeUtils.scale(13.5, size.width)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    AppShadow.shadowWithColor(color.withOpacity(0.19))
                  ],
                  color: color,
                ),
                child: SvgIcon(
                  icon: svgIcon,
                  height: SizeUtils.scale(21, size.width),
                  width: SizeUtils.scale(21, size.width),
                  color: Colors.white,
                )),
            SizedBox(
              height: SizeUtils.scale(10, size.width),
            ),
            MyText(
              text: title,
              style: AppFonts.TitleSmall,
            )
          ],
        ),
      ),
    );
  }
}
