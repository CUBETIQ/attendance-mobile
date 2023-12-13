import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
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
          width: size.width * 0.35,
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: MyText(
            text: title ?? "Title",
            style: BodyMediumRegular,
          ),
        ),
        Container(
          width: size.width * 0.35,
          padding: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: MyText(
            text: value != "" && value != null ? value ?? "N/A" : "N/A",
            style: BodyMediumRegular,
          ),
        ),
      ],
    );
  }
}
