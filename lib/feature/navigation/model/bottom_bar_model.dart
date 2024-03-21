class BottomBarModel {
  final String title;
  final String bottomIcon;
  final String? actionIcon;
  final Function()? actionOnTap;
  final double? actionHeight;
  final double? actionWidth;
  final bool? hasColor;

  BottomBarModel({
    required this.title,
    required this.bottomIcon,
    this.actionIcon,
    this.actionHeight,
    this.actionWidth,
    this.hasColor,
    this.actionOnTap,
  });
}
