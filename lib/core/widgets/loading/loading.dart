import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: SizeUtils.scale(30, width)),
      child: Center(
        child: LoadingAnimationWidget.flickr(
          leftDotColor: Theme.of(context).colorScheme.onBackground,
          rightDotColor: Theme.of(context).colorScheme.primary,
          size: SizeUtils.scale(40, width),
        ),
      ),
    );
  }
}
