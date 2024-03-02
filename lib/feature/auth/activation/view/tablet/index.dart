import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/lotties.dart';
import 'package:timesync360/core/widgets/button/async_button.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync360/feature/auth/activation/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/text_formater.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../constants/app_size.dart';

class ActivationViewTablet extends StatelessWidget {
  const ActivationViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ActivationController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.scaleMobile(
                AppSize().paddingHorizontalLarge,
                MediaQuery.of(context).size.width,
              ),
              right: SizeUtils.scaleMobile(
                AppSize().paddingHorizontalLarge,
                MediaQuery.of(context).size.width,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.83,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.1),
                      Center(
                        child: SizedBox(
                          width: size.width * 0.8,
                          child: Lottie.asset(
                            LottieAssets.lottieActivation,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      MyText(
                        text: controller.title,
                        maxLines: 1,
                        style: AppFonts().bodyXlarge,
                      ),
                      SizedBox(height: size.height * 0.01),
                      MyText(
                        text: controller.description,
                        maxLines: 5,
                        style: AppFonts().bodySmallMedium,
                      ),
                      SizedBox(height: size.height * 0.01),
                      MyTextFieldForm(
                        hasLabel: false,
                        prefixIcon: Icons.vpn_key_rounded,
                        textCapitalization: TextCapitalization.characters,
                        label: "Activation",
                        hintText: "Enter your activation code",
                        textController: controller.activationController,
                        inputFormatters: [UpperCaseTextFormatter()],
                      ),
                    ],
                  ),
                ),
                MyAsyncButton(
                  title: "Activate",
                  height: SizeUtils.scaleTablet(
                    50,
                    MediaQuery.of(context).size.width,
                  ),
                  onTap: controller.activation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
