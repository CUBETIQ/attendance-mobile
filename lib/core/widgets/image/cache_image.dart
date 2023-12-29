import 'package:attendance_app/constants/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyCacheImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const MyCacheImage(
      {super.key, required this.imageUrl, this.width, this.height});

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
          color: Colors.red,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
      errorWidget: (context, url, error) => Container(
        width: width ?? 55,
        height: height ?? 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.withOpacity(0.4),
        ),
        child: SizedBox(
          width: width ?? 55,
          height: height ?? 55,
          child: SvgPicture.asset(
            defaultUser,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
