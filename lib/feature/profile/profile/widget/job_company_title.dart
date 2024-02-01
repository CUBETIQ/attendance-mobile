import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class JobCompanyTitle extends StatelessWidget {
  final String organization;
  final String position;

  const JobCompanyTitle({
    super.key,
    required this.organization,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.35,
          ),
          child: MyText(
            text: organization,
            style: BodyMediumRegular.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        MyText(
          text: " | ",
          style: BodyMediumRegular.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.35,
          ),
          child: MyText(
            text: position,
            style: BodyMediumRegular.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
