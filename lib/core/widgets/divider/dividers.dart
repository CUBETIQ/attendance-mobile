import 'package:flutter/material.dart';
import 'package:timesync/utils/size_util.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key, this.opacity, this.thickness});

  final double? opacity;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Divider(
      thickness: SizeUtils.scale(thickness ?? 1, size.width),
      color: Theme.of(context)
          .colorScheme
          .outlineVariant
          .withOpacity(opacity ?? 0.7),
    );
  }
}
