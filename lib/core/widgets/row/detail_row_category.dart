import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class DetailRowCategory extends StatelessWidget {
  const DetailRowCategory({super.key, this.title, this.icon, this.color});

  final String? title;
  final String? icon;
  final String? color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: SizeUtils.scaleMobile(160, size.width),
          child: MyText(
            text: title ?? "category",
            style: AppFonts().bodyMediumMedium.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
        Container(
          width: SizeUtils.scaleMobile(25, size.width),
          height: SizeUtils.scaleMobile(25, size.width),
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
            size: SizeUtils.scaleMobile(15, size.width),
            color: Colors.white,
          ),
        ),
        SizedBox(width: SizeUtils.scaleMobile(10, size.width)),
      ],
    );
  }
}
