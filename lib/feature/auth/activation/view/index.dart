import 'package:lottie/lottie.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/lotties.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/auth/activation/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/text_formater.dart';
import '../../../../core/widgets/textfield/texfield_validate.dart';

class ActivationView extends StatelessWidget {
  const ActivationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ActivationController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.scale(
                AppSize().paddingHorizontalLarge,
                size.width,
              ),
              right: SizeUtils.scale(
                AppSize().paddingHorizontalLarge,
                size.width,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
                Center(
                  child: SizedBox(
                    width: SizeUtils.scale(
                      400,
                      size.width,
                    ),
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
                  iconSize: SizeUtils.scale(16, size.width),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          bottom: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
        ),
        child: MyAsyncButton(
          title: "Activate",
          onTap: controller.activation,
        ),
      ),
    );
  }
}
