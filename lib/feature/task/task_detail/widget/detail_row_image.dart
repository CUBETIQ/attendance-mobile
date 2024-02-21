import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class DetailRowImage extends StatelessWidget {
  const DetailRowImage({super.key, this.title, this.image, this.name});

  final String? title;
  final String? name;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: SizeUtils.scale(160, size.width),
          child: MyText(
            text: title ?? "status",
            style: AppStyles().bodyMediumMedium.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
        MyCacheImage(
          imageUrl: image ?? "",
          width: SizeUtils.scale(25, size.width),
          height: SizeUtils.scale(25, size.width),
        ),
        SizedBox(width: SizeUtils.scale(10, size.width)),
        Expanded(
          child: MyText(
            text: name ?? "name",
            style: AppStyles().bodyMediumMedium,
          ),
        ),
      ],
    );
  }
}
