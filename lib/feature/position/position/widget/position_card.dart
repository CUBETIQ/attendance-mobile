import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class PositionCard extends StatelessWidget {
  const PositionCard({
    super.key,
    required this.position,
    this.onTap,
    this.onTapViewDetail,
  });

  final PositionModel position;
  final void Function()? onTap;
  final void Function()? onTapViewDetail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: MyCard(
        width: size.width,
        height: SizeUtils.scale(60, size.width),
        padding: EdgeInsets.symmetric(
          horizontal:
              SizeUtils.scale(AppSize.paddingHorizontalLarge, size.width),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MyCacheImage(
                  imageUrl: position.image ?? "",
                  defaultImage: SvgAssets.position,
                  width: SizeUtils.scale(45, size.width),
                  height: SizeUtils.scale(45, size.width),
                  imageWidth: SizeUtils.scale(30, size.width),
                  imageHeight: SizeUtils.scale(30, size.width),
                ),
                SizedBox(width: SizeUtils.scale(10, size.width)),
                MyText(
                  text: position.name ?? "",
                  style: BodyMediumMedium,
                ),
              ],
            ),
            GestureDetector(
              onTap: onTapViewDetail,
              child: Container(
                padding: EdgeInsets.all(
                  SizeUtils.scale(5, size.width),
                ),
                child: Row(
                  children: [
                    MyText(
                      text: "View Detail",
                      style: BodySmallMedium.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: SizeUtils.scale(5, size.width)),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: SizeUtils.scale(15, size.width),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
