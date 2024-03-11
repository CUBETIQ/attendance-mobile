import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/svg_util.dart';
import 'package:timesync/utils/date_util.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
    required this.data,
    this.icon,
    this.onTapIcon,
    this.trailing,
  });

  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final AttachmentModel data;
  final IconData? icon;
  final void Function()? onTapIcon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width,
      height: height ?? SizeUtils.scale(60, size.width),
      margin: EdgeInsets.only(
        bottom: SizeUtils.scale(AppSize().paddingS2, size.width),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyCard(
            width: imageWidth ?? SizeUtils.scale(60, size.width),
            height: imageHeight ?? SizeUtils.scale(60, size.width),
            borderRadius: BorderRadius.circular(
              SizeUtils.scale(AppSize().borderRadiusMedium, size.width),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.zero,
            alignment: FileUtil.checkFileImageExtension(data.extension) == true
                ? null
                : FileUtil.checkFileImageExtension(
                            extension(data.file!.path)) ==
                        true
                    ? null
                    : Alignment.center,
            clip: Clip.antiAliasWithSaveLayer,
            child: data.file != null
                ? FileUtil.checkFileImageExtension(
                            extension(data.file!.path)) ==
                        true
                    ? Image.file(
                        data.file!,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(
                        width: SizeUtils.scale(35, size.width),
                        height: SizeUtils.scale(35, size.width),
                        child: SvgPicture.asset(
                          SvgUtil.getSvgByExtenion(extension(data.file!.path)),
                          fit: BoxFit.cover,
                        ),
                      )
                : FileUtil.checkFileImageExtension(data.extension) == true
                    ? Image.network(
                        data.url ?? "",
                        fit: BoxFit.cover,
                      )
                    : SizedBox(
                        width: SizeUtils.scale(35, size.width),
                        height: SizeUtils.scale(35, size.width),
                        child: SvgPicture.asset(
                          SvgUtil.getSvgByExtenion(data.extension),
                          fit: BoxFit.cover,
                        ),
                      ),
          ),
          SizedBox(
            width: SizeUtils.scale(10, size.width),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scale(2.5, size.width),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: SizeUtils.scale(200, size.width),
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
                      ? FileUtil.getFileSizeWithFile(data.file!)
                      : FileUtil.getFileSizeFromByte(data.size),
                  style: AppFonts().bodyMediumMedium.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                MyText(
                  text: DateUtil.formatMillisecondsToDOB(
                    data.date ?? DateTime.now().millisecondsSinceEpoch,
                  ),
                  style: AppFonts().bodySmallMedium.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTapIcon,
            child: trailing ?? Icon(icon ?? Icons.delete_forever_rounded),
          )
        ],
      ),
    );
  }
}
