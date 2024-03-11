import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class DetailRowImage extends StatelessWidget {
  const DetailRowImage({
    super.key,
    this.title,
    this.image,
    this.name,
    this.imageWidth,
    this.imageHeight,
  });

  final String? title;
  final String? name;
  final String? image;
  final double? imageWidth;
  final double? imageHeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: SizeUtils.scale(160, size.width),
          child: MyText(
            text: title ?? "status",
            style: AppFonts().bodyMediumMedium.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
        MyCacheImage(
          imageUrl: image ?? "",
          width: imageWidth ?? SizeUtils.scale(25, size.width),
          height: imageHeight ?? SizeUtils.scale(25, size.width),
        ),
        SizedBox(width: SizeUtils.scale(10, size.width)),
        Expanded(
          child: MyText(
            text: name ?? "name",
            style: AppFonts().bodyMediumMedium,
          ),
        ),
      ],
    );
  }
}
