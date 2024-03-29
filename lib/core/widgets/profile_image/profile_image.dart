import 'dart:io';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:flutter/material.dart';

class MyProfileImage extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final double? width;
  final double? height;
  final String? defaultImage;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit? fit;

  const MyProfileImage({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.width,
    this.height,
    this.defaultImage,
    this.imageWidth,
    this.imageHeight,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return imageFile != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.file(
              imageFile!,
              width: width ?? 100,
              height: height ?? 100,
              fit: BoxFit.cover,
            ),
          )
        : imageUrl?.startsWith('assets') == true
            ? Container(
                width: width ?? 100,
                height: height ?? 100,
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
                child: Image.asset(
                  imageUrl ?? "",
                  width: imageWidth ?? width ?? 90,
                  height: imageHeight ?? height ?? 90,
                  fit: fit ?? BoxFit.cover,
                ),
              )
            : MyCacheImage(
                imageUrl: imageUrl ?? "",
                width: width ?? 100,
                height: height ?? 100,
                imageWidth: imageWidth ?? width ?? 90,
                imageHeight: imageHeight ?? height ?? 90,
                defaultImage: defaultImage,
              );
  }
}
