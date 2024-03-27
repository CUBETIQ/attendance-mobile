import 'package:flutter/material.dart';
import 'package:timesync/utils/size_util.dart';

class MyBottomPaddingCard extends StatelessWidget {
  const MyBottomPaddingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: SizeUtils.scale(20, size.width),
    );
  }
}
