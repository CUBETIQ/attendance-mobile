import 'package:flutter/material.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/svg_util.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    required this.data,
    this.icon,
    this.onTapIcon,
    this.trailing,
  });

  final AttachmentModel data;
  final IconData? icon;
  final void Function()? onTapIcon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.only(bottom: SizeUtils.scale(12, size.width)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: EdgeInsets.all(SizeUtils.scale(16, size.width)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeUtils.scale(16, size.width)),
                  child: SvgIcon(
                    icon: SvgUtil.getSvgByExtenion(
                        data.file?.path.split('.').last),
                    height: SizeUtils.scale(24, size.width),
                    width: SizeUtils.scale(24, size.width),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: data.file != null
                            ? FileUtil.getFileName(data.file!)
                            : data.name ?? "Attachment",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.LabelMedium.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeUtils.scale(2, size.width)),
                        child: MyText(
                          text:
                              "${DateUtil.formatMillisecondsToDOB(data.date ?? DateTime.now().millisecondsSinceEpoch)}. ${data.file != null ? FileUtil.getFileSizeWithFile(data.file!) : FileUtil.getFileSizeFromByte(data.size)}",
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.BodyXSmall.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
                onTap: onTapIcon,
                child: trailing ??
                    SvgIcon(
                      icon: IconAssets.delete,
                      height: SizeUtils.scale(15.42, size.width),
                      width: SizeUtils.scale(14.13, size.width),
                      color: Theme.of(context).colorScheme.error,
                    ))
          ],
        ),
      ),
    );
  }
}
