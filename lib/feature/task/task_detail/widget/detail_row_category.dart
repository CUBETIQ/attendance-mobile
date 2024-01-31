import 'package:timesync360/config/font.dart';
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
          width: SizeUtils.scale(160, size.width),
          child: MyText(
            text: title ?? "status",
            style: BodyMediumMedium.copyWith(
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
      ],
    );
  }
}
