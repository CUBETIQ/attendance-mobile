// ignore_for_file: prefer_const_constructors

import 'package:cubetiq_attendance_app/components/text/text.dart';
import 'package:cubetiq_attendance_app/config/theme/color/color_app.dart';
import 'package:cubetiq_attendance_app/data/getx/controller/check_network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetWorkBar extends StatelessWidget {
  const NetWorkBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ConnectivityService(),
      autoRemove: true,
      builder: (controller) {
        return controller.connectionStatus.value == 0
            ? Positioned.fill(
                top: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CupertinoActivityIndicator(
                            color: MyAppColor.instance.light.L5,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          const MyText(
                              text: 'No internet connection',
                              style: TextStyle(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ]),
                  ),
                ),
              )
            : SizedBox.shrink();
      },
    );
  }
}
