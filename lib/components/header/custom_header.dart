import 'package:cubetiq_attendance_app/components/svg/custom_svg.dart';
import 'package:cubetiq_attendance_app/components/text/text.dart';
import 'package:cubetiq_attendance_app/config/reusable/svgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHeader extends StatelessWidget {
  final String text;
  final bool? isCenter;
  final VoidCallback? onPressed;
  final Widget? body;
  final bool isLeading;
  final List<Widget>? actions;
  final bool? resizeToAvoidBottomInset;
  const MyHeader(
      {super.key,
      this.body,
      this.isLeading = false,
      this.actions,
      this.isCenter,
      this.text = "Your title",
      this.resizeToAvoidBottomInset,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Row(
              children: actions ?? [],
            ),
          )
        ],
        elevation: 0.0,
        leading: isLeading
            ? const SizedBox.shrink()
            : IconButton(
                onPressed: onPressed ?? Get.back,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: CustomSvg(
                  svg: SvgString.back,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
        centerTitle: isCenter ?? true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: MyText(
          text: text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 18,
              ),
        ),
      ),
      body: body,
    );
  }
}
