import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.7),
    );
  }
}
