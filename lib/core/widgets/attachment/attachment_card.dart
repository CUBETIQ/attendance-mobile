import 'package:flutter/material.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/image.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
  });

  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width,
      height: height ?? SizeUtils.scaleMobile(70, size.width),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyCard(
            width: imageWidth ?? SizeUtils.scaleMobile(70, size.width),
            height: imageHeight ?? SizeUtils.scaleMobile(70, size.width),
            padding: EdgeInsets.zero,
            clip: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              ImageAssets.logoTimeSync360,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: SizeUtils.scaleMobile(8, size.width),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scaleMobile(6, size.width),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "TimeSync360.png",
                  style: AppFonts().bodyMediumMedium,
                ),
                MyText(
                  text: "300 KB",
                  style: AppFonts().bodyMediumMedium.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                MyText(
                  text: "Feb 01 2024",
                  style: AppFonts().bodySmallMedium.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.delete_outline_rounded)
        ],
      ),
    );
  }
}
