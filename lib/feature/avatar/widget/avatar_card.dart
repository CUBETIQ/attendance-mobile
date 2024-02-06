import 'package:flutter/material.dart';
import 'package:timesync360/utils/size_util.dart';
import '../../../types/avatar_type.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    super.key,
    this.width,
    this.height,
    required this.avatarType,
    required this.image,
    this.onTap,
  });

  final double? width;
  final double? height;
  final String avatarType;
  final void Function()? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? SizeUtils.scale(80, size.width),
        height: height ?? SizeUtils.scale(80, size.width),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        child: Image.asset(
          image,
          width: SizeUtils.scale(
            avatarType == AvatarType.profile
                ? 75
                : avatarType == AvatarType.organization
                    ? 50
                    : 60,
            size.width,
          ),
          height: SizeUtils.scale(
            avatarType == AvatarType.profile
                ? 75
                : avatarType == AvatarType.organization
                    ? 50
                    : 60,
            size.width,
          ),
        ),
      ),
    );
  }
}
