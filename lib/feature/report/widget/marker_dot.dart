import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class MarkerDot extends StatelessWidget {
  const MarkerDot({super.key, required this.events});

  final List<Object?> events;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            top: SizeUtils.scaleMobile(40, size.width),
          ),
          child: Container(
            height: SizeUtils.scaleMobile(6, size.width),
            width: SizeUtils.scaleMobile(6, size.width),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: events[index] == 'Present'
                  ? Colors.green
                  : events[index] == 'Leave'
                      ? Colors.orange
                      : Colors.red,
            ),
          ),
        );
      },
    );
  }
}
