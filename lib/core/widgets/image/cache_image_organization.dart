import 'package:timesync/constants/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timesync/utils/size_util.dart';

class MyCacheImageOrganization extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final BoxBorder? border;

  const MyCacheImageOrganization({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return imageUrl != "" && imageUrl != null
        ? imageUrl?.startsWith('assets') == true
            ? Container(
                width: SizeUtils.scale(width ?? 55, size.width),
                height: SizeUtils.scale(height ?? 55, size.width),
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
                  width: SizeUtils.scale(imageWidth ?? width ?? 55, size.width),
                  height:
                      SizeUtils.scale(imageHeight ?? height ?? 55, size.width),
                  child: Image.asset(
                    imageUrl ?? "",
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  width: SizeUtils.scale(width ?? 55, size.width),
                  height: SizeUtils.scale(height ?? 55, size.width),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    border: border,
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
                  width: SizeUtils.scale(width ?? 55, size.width),
                  height: SizeUtils.scale(height ?? 55, size.width),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
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
                    width: (SizeUtils.scale(width ?? 55, size.width)) / 4,
                    height: (SizeUtils.scale(height ?? 55, size.width)) / 4,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: SizeUtils.scale(width ?? 55, size.width),
                  height: SizeUtils.scale(height ?? 55, size.width),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  child: SizedBox(
                    child: SvgPicture.asset(SvgAssets.company),
                  ),
                ),
              )
        : Container(
            width: SizeUtils.scale(width ?? 55, size.width),
            height: SizeUtils.scale(height ?? 55, size.width),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            child: SizedBox(
              width: SizeUtils.scale(imageWidth ?? width ?? 55, size.width),
              height: SizeUtils.scale(imageHeight ?? height ?? 55, size.width),
              child: SvgPicture.asset(
                SvgAssets.company,
              ),
            ),
          );
  }
}
