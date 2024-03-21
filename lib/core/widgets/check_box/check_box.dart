import 'package:flutter/material.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/utils/size_util.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({
    super.key,
    required this.isChecked,
    this.onTap,
    this.boxSize,
    this.borderRadius,
  });

  final bool isChecked;
  final void Function()? onTap;
  final double? boxSize;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: boxSize ?? SizeUtils.scale(18.5, size.width),
        height: boxSize ?? SizeUtils.scale(18.5, size.width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              SizeUtils.scale(borderRadius ?? AppSpacing.XS, size.width)),
          border: Border.all(
            width: SizeUtils.scale(1.5, size.width),
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          color: isChecked
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: SizeUtils.scale(
                    (boxSize != null ? (boxSize!) : (18.5 / 1.3)), size.width),
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : null,
      ),
    );
  }
}
