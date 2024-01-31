import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:timesync360/config/font.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  final String title;
  final int? speed;
  final bool? repeat;
  final TextStyle? textStyle;

  const AnimatedText(
      {super.key,
      required this.title,
      this.speed,
      this.repeat,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        WavyAnimatedText(
          title,
          speed: Duration(milliseconds: speed ?? 250),
          textStyle: textStyle ?? BodyXlargeMedium,
          textAlign: TextAlign.center,
        ),
      ],
      isRepeatingAnimation: repeat ?? true,
    );
  }
}
