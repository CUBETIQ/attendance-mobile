import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:timesync/constants/lotties.dart';
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
    this.selected,
  });

  final ThemeModel data;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final double? colorHeight;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: SizeUtils.scale(70, size.width),
            height: SizeUtils.scale(70, size.width),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                SizeUtils.scale(
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
                            colorHeight ?? SizeUtils.scale(34.5, size.width),
                        decoration: BoxDecoration(
                          color: data.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: SizeUtils.scale(1, size.width)),
                    Expanded(
                      child: Container(
                        height:
                            colorHeight ?? SizeUtils.scale(34.5, size.width),
                        decoration: BoxDecoration(
                          color: data.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeUtils.scale(1, size.width)),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height:
                            colorHeight ?? SizeUtils.scale(34.5, size.width),
                        decoration: BoxDecoration(
                          color: data.primaryContainer,
                        ),
                      ),
                    ),
                    SizedBox(width: SizeUtils.scale(1, size.width)),
                    Expanded(
                      child: Container(
                        height:
                            colorHeight ?? SizeUtils.scale(34.5, size.width),
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
          selected == true
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: SizeUtils.scale(70, size.width),
                      height: SizeUtils.scale(70, size.width),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(
                          SizeUtils.scale(
                            18,
                            size.width,
                          ),
                        ),
                      ),
                    ),
                    Lottie.asset(
                      LottieAssets.tick,
                      repeat: false,
                      width: SizeUtils.scale(50, size.width),
                      height: SizeUtils.scale(50, size.width),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
