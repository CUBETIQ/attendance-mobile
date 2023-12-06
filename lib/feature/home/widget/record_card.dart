import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final double? width;
  final double? height;

  const RecordCard({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1.2,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
