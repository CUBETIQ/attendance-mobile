import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/config/svg.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/button/outline_button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/core/widgets/textfield/texfield_validate.dart';
import 'package:attendance_app/feature/auth/login/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginViewMobile extends StatelessWidget {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.to;
    return SafeArea(
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
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: SvgPicture.asset(logo),
                    ),
                    const SizedBox(height: AppSize.paddingS6),
                    MyText(
                      text: "Time Glitch",
                      style: BodyLargeMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.spacingS20),
              MyText(
                text: "Access your account",
                style: BodyXXlarge,
              ),
              MyText(
                text: "Please fill your detail to access your account.",
                style: BodyMediumRegular.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              MyTextFieldForm(
                label: "Username",
                hintText: "Enter your username",
                textController: controller.usernameController,
              ),
              const SizedBox(height: AppSize.spacingS11),
              MyTextFieldForm(
                label: "Password",
                hintText: "Enter your password  ",
                textController: controller.passwordController,
              ),
              const SizedBox(height: AppSize.spacingS9),
              MyButton(
                title: "Login",
                onTap: controller.login,
              ),
              const SizedBox(height: AppSize.spacingS9),
              MyOutLineButton(
                title: "Sign in With",
                onTap: controller.loginWithGoogle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
