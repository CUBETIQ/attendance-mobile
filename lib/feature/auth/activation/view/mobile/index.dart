import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/lotties.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/text_formater.dart';
import 'package:attendance_app/feature/auth/activation/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/widgets/textfield/texfield_validate.dart';

class ActivationViewMobile extends StatelessWidget {
  const ActivationViewMobile({super.key});

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
                AppSize.paddingHorizontalLarge,
                MediaQuery.of(context).size.width,
              ),
              right: SizeUtils.scale(
                AppSize.paddingHorizontalLarge,
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
                        style: BodyXlarge,
                      ),
                      SizedBox(height: size.height * 0.01),
                      MyText(
                        text: controller.description,
                        maxLines: 5,
                        style: BodySmallMedium,
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
                MyButton(
                  title: "Activate",
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
