import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class JobCompanyTitle extends StatelessWidget {
  final String organization;
  final String? position;

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
            style: AppFonts().bodyMediumRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        position != null
            ? MyText(
                text: " | ",
                style: AppFonts().bodyMediumRegular.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              )
            : const SizedBox.shrink(),
        Container(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.35,
          ),
          child: MyText(
            text: position ?? "",
            style: AppFonts().bodyMediumRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}
