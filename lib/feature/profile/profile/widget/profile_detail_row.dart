import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ProfileDetailRow extends StatelessWidget {
  final String? title;
  final String? value;

  const ProfileDetailRow({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: SizeUtils.scale(80, size.width),
          ),
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: MyText(
            text: title ?? "Title",
            style: BodyMediumRegular,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: SizeUtils.scale(170, size.width),
          ),
          padding: EdgeInsets.only(right: SizeUtils.scale(10, size.width)),
          alignment: Alignment.centerRight,
          child: MyText(
            text: value != "" && value != null
                ? value.capitalizeMaybeNull ?? "N/A"
                : "N/A",
            style: BodyMediumRegular,
          ),
        ),
      ],
    );
  }
}
