import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/image.dart';
import 'package:timesync/feature/splash/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/splash/widgets/animated_text.dart';
import 'package:timesync/utils/size_util.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SplashController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onLongPress: controller.onResetApp,
              splashColor: Colors.transparent,
              child: FadeTransition(
                opacity: controller.animation,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SizeUtils.scale(
                        AppSize().borderRadiusXLarge,
                        size.width,
                      ),
                    ),
                  ),
                  height: SizeUtils.scale(100, size.width),
                  child: Image.asset(
                    ImageAssets.logotimesync,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeUtils.scale(30, size.width),
            ),
            AnimatedText(
              title: controller.title,
            )
          ],
        ),
      ),
    );
  }
}
