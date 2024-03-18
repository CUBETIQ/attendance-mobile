import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ProfileDetailRow extends StatelessWidget {
  final String? title;
  final String? value;
  final int? maxline;

  const ProfileDetailRow({super.key, this.title, this.value, this.maxline});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          child: MyText(
            text: title ?? "Title",
            style: AppFonts().bodyMediumRegular,
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(right: SizeUtils.scale(10, size.width)),
            alignment: Alignment.centerRight,
            child: MyText(
              text: value != "" && value != null
                  ? value.capitalizeMaybeNull ?? "N/A"
                  : "N/A",
              maxLines: maxline ?? 1,
              overflow: TextOverflow.ellipsis,
              style: AppFonts().bodyMediumRegular,
            ),
          ),
        ),
      ],
    );
  }
}
