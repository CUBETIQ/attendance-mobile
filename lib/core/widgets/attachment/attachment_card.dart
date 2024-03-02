import 'package:flutter/material.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/attachment_model.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/file_util.dart';
import 'package:timesync360/utils/size_util.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
    required this.data,
    this.onTapDelete,
  });

  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final AttachmentModel data;
  final void Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width,
      height: height ?? SizeUtils.scaleMobile(60, size.width),
      margin: EdgeInsets.only(
        bottom: SizeUtils.scaleMobile(AppSize().paddingS2, size.width),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyCard(
            width: imageWidth ?? SizeUtils.scaleMobile(60, size.width),
            height: imageHeight ?? SizeUtils.scaleMobile(60, size.width),
            borderRadius: BorderRadius.circular(
              SizeUtils.scaleMobile(AppSize().borderRadiusMedium, size.width),
            ),
            padding: EdgeInsets.zero,
            clip: Clip.antiAliasWithSaveLayer,
            child: data.file != null
                ? Image.file(
                    data.file!,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    data.url ?? "",
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(
            width: SizeUtils.scaleMobile(8, size.width),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scaleMobile(4, size.width),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: SizeUtils.scaleMobile(200, size.width),
                  ),
                  child: MyText(
                    text: data.file != null
                        ? FileUtil.getFileName(data.file!)
                        : data.name ?? "Attachment",
                    style: AppFonts().bodyMediumMedium,
                  ),
                ),
                MyText(
                  text: data.file != null
                      ? FileUtil.getFileSize(data.file!)
                      : "300 KB",
                  style: AppFonts().bodyMediumMedium.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                MyText(
                  text: "Feb 01 2024",
                  style: AppFonts().bodySmallMedium.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTapDelete,
            child: const Icon(Icons.delete_forever_rounded),
          )
        ],
      ),
    );
  }
}
