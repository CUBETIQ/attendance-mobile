import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/config/lotties.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
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
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSize.paddingTitleLarge,
              left: AppSize.paddingHorizontalLarge,
              right: AppSize.paddingHorizontalLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSize.spacingS15),
                      SizedBox(
                        width: double.infinity,
                        child: Lottie.asset(
                          lottieActivation,
                          fit: BoxFit.cover,
                        ),
                      ),
                      MyText(
                        text: controller.title,
                        maxLines: 1,
                        style: BodyXlarge,
                      ),
                      const SizedBox(height: AppSize.spacingS3),
                      MyText(
                        text: controller.description,
                        maxLines: 5,
                        style: BodySmallMedium,
                      ),
                      const SizedBox(height: AppSize.spacingS8),
                      MyTextFieldForm(
                        hasLabel: false,
                        label: "Activation",
                        hintText: "Enter your activation code",
                        textController: controller.activationController,
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
