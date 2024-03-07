import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/lotties.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/customer_support/controller/index.dart';
import 'package:timesync/feature/customer_support/widget/support_button.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomerSupportViewMobile extends StatelessWidget {
  const CustomerSupportViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = CustomerSupportController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: 'Support',
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.asset(
                LottieAssets.customerService,
                height: SizeUtils.scaleMobile(300, size.width),
                width: SizeUtils.scaleMobile(300, size.width),
              ),
            ),
            MyText(
              text: 'Hello, How can we Help you?',
              style: AppFonts().bodyXlargeMedium,
            ),
            SizedBox(
              height: SizeUtils.scaleMobile(40, size.width),
            ),
            ...List.generate(
              controller.buttons.length,
              (index) => SupportButton(
                margin: EdgeInsets.only(
                  left: SizeUtils.scaleMobile(
                    AppSize().paddingHorizontalLarge,
                    size.width,
                  ),
                  right: SizeUtils.scaleMobile(
                    AppSize().paddingHorizontalLarge,
                    size.width,
                  ),
                  bottom: SizeUtils.scaleMobile(
                    10,
                    size.width,
                  ),
                ),
                buttonModel: controller.buttons[index],
              ),
            )
          ],
        ),
      ),
    );
  }
}
