import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/widgets/attachment/attachment_card.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/size_util.dart';

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
          Padding(
            padding: EdgeInsets.only(bottom: SizeUtils.scale(12, size.width)),
            child: GestureDetector(
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
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: dotStrokeWidth ?? 2.5,
                borderType: BorderType.RRect,
                radius: Radius.circular(
                  SizeUtils.scale(12, size.width),
                ),
                dashPattern: dashPattern ?? const [1, 8],
                strokeCap: StrokeCap.square,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: MyColor.base2,
                    borderRadius: BorderRadius.circular(
                      SizeUtils.scale(12, size.width),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.scale(16, size.width),
                        vertical: SizeUtils.scale(12, size.width)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: SizeUtils.scale(8, size.width)),
                          child: SvgIcon(
                              icon: IconAssets.paperUpload,
                              height: SizeUtils.scale(21.43, size.width),
                              width: SizeUtils.scale(18.15, size.width),
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "${"Browse".trString} ",
                                  style: AppFonts.LabelMedium.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                TextSpan(
                                  text: "files to upload".trString,
                                  style: AppFonts.LabelMedium.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeUtils.scale(4, size.width)),
                              child: MyText(
                                text: "You can upload up to 3 files.",
                                style: AppFonts.BodyXSmall.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
