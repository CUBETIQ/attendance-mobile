import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.description,
    this.onChanged,
    this.value = false,
  });

  final double? width;
  final double? height;
  final String title;
  final String description;
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width,
      height: height,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.dark_mode_rounded,
                size: SizeUtils.scale(30, size.width),
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: SizeUtils.scale(15, size.width)),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: title,
                      style: AppStyles().bodyLargeMedium,
                    ),
                    MyText(
                      text: description,
                      maxLines: 2,
                      style: AppStyles().bodySmallRegular.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Switch(
                value: value,
                onChanged: onChanged,
              ),
            ],
          ),
          SizedBox(height: SizeUtils.scale(5, size.width)),
          Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.scale(45, size.width),
            ),
            child: const Divider(),
          ),
        ],
      ),
    );
  }
}
