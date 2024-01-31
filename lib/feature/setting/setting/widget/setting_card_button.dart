import 'package:timesync360/config/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class SettingCardButton extends StatelessWidget {
  const SettingCardButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.description,
    this.onTap,
    this.leadingIcon,
  });

  final double? width;
  final double? height;
  final String title;
  final String description;
  final void Function()? onTap;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width ?? size.width,
        height: height,
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  leadingIcon ?? Icons.question_mark_rounded,
                  size: SizeUtils.scale(30, size.width),
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: SizeUtils.scale(15, size.width)),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: title,
                        style: BodyLargeMedium,
                      ),
                      MyText(
                        text: description,
                        maxLines: 2,
                        style: BodySmallRegular.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: SizeUtils.scale(20, size.width),
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
            SizedBox(height: SizeUtils.scale(5, size.width)),
            Padding(
              padding: EdgeInsets.only(
                left: SizeUtils.scale(45, size.width),
              ),
              child: const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
