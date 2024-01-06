import 'package:attendance_app/constants/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyCacheImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final Color? colors;
  final double? imageWidth;
  final double? imageHeight;

  const MyCacheImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.colors,
    this.imageWidth,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width ?? 55,
        height: height ?? 55,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
      errorWidget: (context, url, error) => Container(
        width: width ?? 55,
        height: height ?? 55,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors ?? Colors.blue.withOpacity(0.4),
        ),
        child: Column(
          children: [
            SizedBox(
              width: imageWidth ?? width ?? 55,
              height: imageHeight ?? height ?? 55,
              child: SvgPicture.asset(
                defaultUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
