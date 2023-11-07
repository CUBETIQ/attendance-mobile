import 'package:cubetiq_attendance_app/config/reusable/animations.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 80,
        height: height ?? 80,
        child: Lottie.asset(LottieString.loading),
      ),
    );
  }
}
