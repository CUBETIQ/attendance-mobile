import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/lotties.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/core/widgets/textfield/texfield_validate.dart';
import 'package:attendance_app/feature/auth/activation/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/text_formater.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../config/app_size.dart';

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
              top: AppSize.paddingTitleLarge,
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
                      SizedBox(
                        width: size.width * 0.8,
                        child: Lottie.asset(
                          lottieActivation,
                          fit: BoxFit.cover,
                        ),
                      ),
                      MyText(
                        text: controller.title,
                        maxLines: 1,
                        style: BodyXXXlarge,
                      ),
                      SizedBox(height: size.height * 0.01),
                      MyText(
                        text: controller.description,
                        maxLines: 5,
                        style: BodyLargeMedium,
                      ),
                      SizedBox(height: size.height * 0.05),
                      Center(
                        child: SizedBox(
                          width: size.width * 0.5,
                          child: MyTextFieldForm(
                            hasLabel: false,
                            textCapitalization: TextCapitalization.characters,
                            label: "Activation",
                            hintText: "Enter your activation code",
                            textController: controller.activationController,
                            inputFormatters: [UpperCaseTextFormatter()],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.1),
                      Center(
                        child: MyButton(
                          width: size.width * 0.5,
                          title: "Activate",
                          onTap: controller.activation,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
