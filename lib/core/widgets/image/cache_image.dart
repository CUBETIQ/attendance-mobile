import 'package:timesync360/constants/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timesync360/utils/size_util.dart';

class MyCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final String? defaultImage;

  const MyCacheImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
    this.defaultImage,
  });

  @override
  Widget build(BuildContext context) {
    final getWidth = MediaQuery.of(context).size.width;
    return imageUrl != "" && imageUrl != null
        ? imageUrl?.startsWith('assets') == true
            ? Container(
                width: width ?? SizeUtils.scaleMobile(55, getWidth),
                height: height ?? SizeUtils.scaleMobile(55, getWidth),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .primary
                      .withOpacity(0.5),
                ),
                child: SizedBox(
                  width: imageWidth ??
                      width ??
                      SizeUtils.scaleMobile(55, getWidth),
                  height: imageHeight ??
                      height ??
                      SizeUtils.scaleMobile(55, getWidth),
                  child: Image.asset(
                    imageUrl ?? "",
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  width: width ?? SizeUtils.scaleMobile(55, getWidth),
                  height: height ?? SizeUtils.scaleMobile(55, getWidth),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
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
                placeholder: (context, url) => Container(
                  width: width ?? 55,
                  height: height ?? 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: SizeUtils.scaleMobile(width ?? 55, getWidth) / 2.5,
                    height: SizeUtils.scaleMobile(height ?? 55, getWidth) / 2.5,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: width ?? 55,
                  height: height ?? 55,
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      defaultImage ?? SvgAssets.defaultUser,
                    ),
                  ),
                ),
              )
        : Container(
            width: width ?? 55,
            height: height ?? 55,
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            child: SizedBox(
              width: imageWidth ?? width ?? 55,
              height: imageHeight ?? height ?? 55,
              child: SvgPicture.asset(
                defaultImage ?? SvgAssets.defaultUser,
              ),
            ),
          );
  }
}
