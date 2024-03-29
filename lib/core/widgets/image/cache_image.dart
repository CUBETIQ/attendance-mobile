import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesync/utils/size_util.dart';

class MyCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final String? defaultImage;
  final bool isRounded;

  const MyCacheImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
    this.defaultImage,
    this.isRounded = true,
  });

  @override
  Widget build(BuildContext context) {
    final getWidth = MediaQuery.of(context).size.width;
    return imageUrl != "" && imageUrl != null
        ? imageUrl?.startsWith('assets') == true
            ? Container(
                width: width ?? SizeUtils.scale(55, getWidth),
                height: height ?? SizeUtils.scale(55, getWidth),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
                  gradient: MyColor.gradient02,
                ),
                child: SizedBox(
                  width: imageWidth ?? width ?? SizeUtils.scale(55, getWidth),
                  height:
                      imageHeight ?? height ?? SizeUtils.scale(55, getWidth),
                  child: Image.asset(
                    imageUrl ?? "",
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  width: width ?? SizeUtils.scale(55, getWidth),
                  height: height ?? SizeUtils.scale(55, getWidth),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
                    gradient: MyColor.gradient02,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: width ?? 55,
                  height: height ?? 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
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
                    width: SizeUtils.scale(width ?? 55, getWidth) / 2.5,
                    height: SizeUtils.scale(height ?? 55, getWidth) / 2.5,
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: MyColor.gradient02,
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: MyColor.gradient02,
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
