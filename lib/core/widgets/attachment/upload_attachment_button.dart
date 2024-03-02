import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/attachment/attachment_card.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/logger.dart';
import 'package:timesync360/utils/size_util.dart';

class UploadAttachmentButton extends StatelessWidget {
  const UploadAttachmentButton({
    super.key,
    this.onTapGallery,
    this.width,
    this.height,
    this.dotRadius,
    this.childBorderRadius,
    this.dashPattern,
    this.dotStrokeWidth,
    this.iconSize,
  });

  final void Function(File file)? onTapGallery;
  final double? width;
  final double? height;
  final Radius? dotRadius;
  final BorderRadiusGeometry? childBorderRadius;
  final List<double>? dashPattern;
  final double? dotStrokeWidth;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            getPickAttachmentButtomSheet(
              context,
              onTapGallery: (file) {
                Logs.i("Gallery file: $file");
              },
              onTapCamera: (file) {
                Logs.i("Camera file: $file");
              },
              onTapFile: (file) {
                Logs.i("File: $file");
              },
            );
          },
          child: DottedBorder(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            strokeWidth: dotStrokeWidth ?? 3.5,
            borderType: BorderType.RRect,
            radius: dotRadius ??
                Radius.circular(
                  SizeUtils.scaleMobile(
                    AppSize().borderRadiusMedium,
                    size.width,
                  ),
                ),
            dashPattern: dashPattern ?? const [1, 8],
            strokeCap: StrokeCap.round,
            child: Container(
              width: width ?? size.width,
              height: height ?? SizeUtils.scaleMobile(120, size.width),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                borderRadius: childBorderRadius ??
                    BorderRadius.circular(
                      SizeUtils.scaleMobile(
                        AppSize().borderRadiusMedium,
                        size.width,
                      ),
                    ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    color: Theme.of(context).colorScheme.primary,
                    size: iconSize ?? SizeUtils.scaleMobile(40, size.width),
                  ),
                  MyText(
                    text: "Upload your files here",
                    style: AppFonts().bodyMediumRegular.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  MyText(
                    text: "Browse",
                    style: AppFonts().bodyLargeSemi.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: SizeUtils.scaleMobile(20, size.width),
        ),
        const AttachmentCard(),
      ],
    );
  }
}
