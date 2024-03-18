import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class DetailRowCategory extends StatelessWidget {
  const DetailRowCategory({
    super.key,
    this.title,
    this.icon,
    this.color,
    this.category,
  });

  final String? title;
  final String? icon;
  final String? color;
  final String? category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: SizeUtils.scale(150, size.width),
          child: MyText(
            text: title ?? "category",
            style: AppFonts().bodyMediumMedium.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
        Container(
          width: SizeUtils.scale(25, size.width),
          height: SizeUtils.scale(25, size.width),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color != null
                ? Color(color!.toInt())
                : Theme.of(context).colorScheme.primary,
          ),
          child: Icon(
            icon?.isEmpty == false
                ? IconData(
                    icon!.toInt(),
                    fontFamily: 'MaterialIcons',
                  )
                : Icons.task,
            size: SizeUtils.scale(15, size.width),
            color: Colors.white,
          ),
        ),
        SizedBox(width: SizeUtils.scale(10, size.width)),
        Expanded(
          child: MyText(
            text: category ?? "Task",
            style: AppFonts().bodyMediumMedium,
          ),
        ),
      ],
    );
  }
}
