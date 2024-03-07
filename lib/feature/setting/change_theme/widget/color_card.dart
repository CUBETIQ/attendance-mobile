import 'package:flutter/material.dart';
import 'package:timesync/feature/setting/change_theme/model/theme_model.dart';
import 'package:timesync/utils/size_util.dart';

class ColorCard extends StatelessWidget {
  const ColorCard({
    super.key,
    required this.data,
    this.onTap,
    this.width,
    this.height,
    this.colorHeight,
  });

  final ThemeModel data;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final double? colorHeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeUtils.scaleMobile(70, size.width),
        height: SizeUtils.scaleMobile(70, size.width),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scaleMobile(
              18,
              size.width,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height:
                        colorHeight ?? SizeUtils.scaleMobile(34.5, size.width),
                    decoration: BoxDecoration(
                      color: data.primary,
                    ),
                  ),
                ),
                SizedBox(width: SizeUtils.scaleMobile(1, size.width)),
                Expanded(
                  child: Container(
                    height:
                        colorHeight ?? SizeUtils.scaleMobile(34.5, size.width),
                    decoration: BoxDecoration(
                      color: data.secondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtils.scaleMobile(1, size.width)),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height:
                        colorHeight ?? SizeUtils.scaleMobile(34.5, size.width),
                    decoration: BoxDecoration(
                      color: data.primaryContainer,
                    ),
                  ),
                ),
                SizedBox(width: SizeUtils.scaleMobile(1, size.width)),
                Expanded(
                  child: Container(
                    height:
                        colorHeight ?? SizeUtils.scaleMobile(34.5, size.width),
                    decoration: BoxDecoration(
                      color: data.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
