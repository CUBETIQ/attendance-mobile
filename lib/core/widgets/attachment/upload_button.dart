import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/attachment_model.dart';
import 'package:timesync360/core/widgets/attachment/attachment_card.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';

class UploadAttachmentButton extends StatelessWidget {
  const UploadAttachmentButton({
    super.key,
    this.width,
    this.height,
    this.dotRadius,
    this.childBorderRadius,
    this.dashPattern,
    this.dotStrokeWidth,
    this.iconSize,
    required this.files,
  });

  final double? width;
  final double? height;
  final Radius? dotRadius;
  final BorderRadiusGeometry? childBorderRadius;
  final List<double>? dashPattern;
  final double? dotStrokeWidth;
  final double? iconSize;
  final RxList<AttachmentModel> files;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: files.length > 2
                ? null
                : () {
                    getPickAttachmentButtomSheet(
                      context,
                      onTapGallery: (file) {
                        AttachmentModel attachment =
                            AttachmentModel(file: file);
                        files.add(attachment);
                      },
                      onTapCamera: (file) {
                        AttachmentModel attachment =
                            AttachmentModel(file: file);
                        files.add(attachment);
                      },
                      onTapFile: (file) {
                        AttachmentModel attachment =
                            AttachmentModel(file: file);
                        files.add(attachment);
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
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.08),
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
              height:
                  SizeUtils.scaleMobile(files.isEmpty ? 0 : 10, size.width)),
          files.isEmpty
              ? const SizedBox.shrink()
              : MyText(
                  text: "Max File: ${files.length}/3",
                  style: AppFonts().bodyLarge.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
          SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
          ...List.generate(
            files.value.length,
            (index) => AttachmentCard(
              data: files[index],
              onTapIcon: () {
                removeFile(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  void removeFile(int index) {
    files.removeAt(index);
  }
}
