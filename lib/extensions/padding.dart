import 'package:flutter/material.dart';

extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> withSpaceBetween({double? width, double? height}) => [
        for (int i = 0; i < length; i++) ...[
          if (i > 0) SizedBox(width: width, height: height),
          this[i],
        ],
      ];

  List<Widget> withSpaceBetweenNoSizedBox({double? width, double? height}) {
    List<Widget> result = [];

    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1 && this[i] is! SizedBox) {
        result.add(SizedBox(width: width, height: height));
      }
    }

    return result;
  }

  List<Widget> withDivide(Color color, EdgeInsetsGeometry padding) => [
        for (int i = 0; i < length; i++) ...[
          Padding(
            padding: padding,
            child: Column(
              children: [
                this[i],
                i == length - 1
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Divider(
                          color: color,
                          height: 1.0,
                        ),
                      )
              ],
            ),
          )
        ],
      ];

  List<Widget> withDivideNoSizedBox(Color color, EdgeInsetsGeometry padding) =>
      [
        for (int i = 0; i < length; i++) ...[
          Padding(
            padding: padding,
            child: Column(
              children: [
                this[i],
                if (this[i] is! SizedBox && i != length - 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Divider(
                      color: color,
                      height: 1.0,
                    ),
                  )
              ],
            ),
          )
        ],
      ];
}
