import 'package:flutter/material.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/utils/size_util.dart';

class ProfielImage extends StatelessWidget {
  const ProfielImage({super.key, this.imageUrl, this.width, this.height});

  final String? imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 0),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: MyCacheImage(
        imageUrl: imageUrl,
        width: width ?? SizeUtils.scaleMobile(100, size.width),
        height: height ?? SizeUtils.scaleMobile(100, size.width),
      ),
    );
  }
}
