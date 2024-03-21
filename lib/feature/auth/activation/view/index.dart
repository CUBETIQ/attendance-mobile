import 'package:lottie/lottie.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/constants/lotties.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeUtils.scale(44, size.width)),
                Center(
                  child: SizedBox(
                    width: SizeUtils.scale(
                      270,
                      size.width,
                    ),
                    child: Lottie.asset(
                      LottieAssets.lottieActivation,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: SizeUtils.scale(23, size.width)),
                MyText(
                  textAlign: TextAlign.center,
                  text: controller.title,
                  maxLines: 2,
                  style: AppFonts.TitleSmall,
                ),
                SizedBox(height: SizeUtils.scale(7, size.width)),
                MyText(
                  text: controller.description,
                  maxLines: 5,
                  style: AppFonts.BodyXSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeUtils.scale(23, size.width)),
                MyTextFieldForm(
                  hasLabel: false,
                  prefixWidget: SvgIcon(
                    icon: IconAssets.key,
                    width: SizeUtils.scale(20, size.width),
                    height: SizeUtils.scale(20, size.width),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  label: "Activation",
                  hintText: "Enter your activation code",
                  textController: controller.activationController,
                  inputFormatters: [UpperCaseTextFormatter()],
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
            55,
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
