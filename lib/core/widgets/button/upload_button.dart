import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/widgets/image/custom_svg.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:timesync360/extensions/file_format.dart';
import 'package:path/path.dart' as path;

class UploadButton extends StatelessWidget {
  final List<File> files;
  final int? fileLimit;
  final double? width;
  final double? height;
  final String? title;
  final Future<void> Function() onTap;
  final TextStyle? style;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  const UploadButton({
    super.key,
    required this.files,
    this.fileLimit,
    this.width,
    this.height,
    this.title,
    required this.onTap,
    this.style,
    this.backgroundColor,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RxBool isDisableButton = false.obs;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => GestureDetector(
            onTap: isDisableButton.value == false
                ? () async {
                    try {
                      isDisableButton.value = true;
                      await onTap();
                    } catch (e) {
                      Logger().e(e);
                      return;
                    } finally {
                      isDisableButton.value = false;
                    }
                  }
                : null,
            child: Container(
              width: width ?? double.infinity,
              height: height ?? 48 * (size.width / 375.0),
              margin: margin,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  (borderRadius ?? AppSize().borderRadiusLarge) *
                      (size.width / 375.0),
                ),
                border: Border.all(
                    color: isDisableButton.value == true
                        ? Theme.of(context).colorScheme.outline.withOpacity(0.3)
                        : backgroundColor ??
                            Theme.of(context).colorScheme.primary),
                color: isDisableButton.value == true
                    ? Theme.of(context).colorScheme.outline.withOpacity(0.3)
                    : backgroundColor ??
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
              child: MyText(
                text: title ?? 'Upload files',
                style: style ??
                    AppStyles().bodyLarge.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: files.isNotEmpty,
          replacement: const SizedBox.shrink(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    text: "Recent File Uploaded",
                  ),
                  MyText(
                    text: "${files.length}/${fileLimit ?? 3}",
                  )
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  for (int i = 0; i < files.length; i++)
                    MyFileTitle(
                      file: files[i],
                      trailing: PopupMenuButton(
                        elevation: 1,
                        onSelected: (value) {
                          if (value == 0) {
                            OpenFile.open(files[i].path);
                          } else {
                            _removeFile(i);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 0,
                              child: Text(
                                "View",
                              ),
                            ),
                            const PopupMenuItem(
                              value: 1,
                              child: Text(
                                "Remove",
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _removeFile(int index) {
    files.removeAt(index);
    Get.back();
  }
}

class MyFileTitle extends StatelessWidget {
  final File file;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const MyFileTitle(
      {super.key, required this.file, this.onPressed, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.0)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          contentPadding: const EdgeInsets.only(left: 20),
          leading: CustomSvg(
            height: 24,
            width: 24,
            svg: file.isImage ? SvgAssets.image : SvgAssets.file,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: MyText(
              text: path.basename(file.path).toUpperCase(),
              textAlign: TextAlign.start,
              maxLines: 1),
          subtitle: MyText(
            text: file.formatFileSize,
            textAlign: TextAlign.start,
            maxLines: 1,
          ),
          trailing: trailing ??
              IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.more_vert_outlined)),
        ),
      ),
    );
  }
}
