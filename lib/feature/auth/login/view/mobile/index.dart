import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/image.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/feature/auth/login/controller/index.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewMobile extends StatelessWidget {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: AppSize().paddingTitleLarge,
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
                Center(
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            SizeUtils.scaleMobile(
                              AppSize().borderRadiusMedium,
                              size.width,
                            ),
                          ),
                        ),
                        height: 70,
                        child: Image.asset(ImageAssets.logotimesync),
                      ),
                      SizedBox(height: AppSize().paddingS6),
                      MyText(
                        text: "timesync",
                        style: AppFonts().bodyLargeMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                MyText(
                  text: "Access your account",
                  style: AppFonts().bodyXXlarge,
                ),
                MyText(
                  text: "Please fill your detail to access your account.",
                  style: AppFonts().bodyMediumRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                SizedBox(height: size.height * 0.05),
                MyTextFieldForm(
                  hasLabel: true,
                  prefixIcon: Icons.person_rounded,
                  label: "Username",
                  hintText: "Enter your username",
                  textController: controller.usernameController,
                ),
                SizedBox(height: size.height * 0.02),
                Obx(
                  () => MyTextFieldForm(
                    hasLabel: true,
                    isPassword: controller.showPassword.value,
                    prefixIcon: Icons.lock_rounded,
                    label: "Password",
                    hintText: "Enter your password",
                    textController: controller.passwordController,
                    haveSuffixIcon: true,
                    onTapShowPassword: controller.onTapShowPassword,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => SizedBox(
                            width: 24 * (size.width / 375.0),
                            height: 24 * (size.width / 375.0),
                            child: Checkbox(
                              value: controller.isRememberMe.value,
                              onChanged: controller.onCheck,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  5 * (size.width / 375.0),
                                ),
                              ),
                              splashRadius: 14,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        MyText(
                          text: "Remember me",
                          style: AppFonts().bodyMediumMedium,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: null,
                      child: MyText(
                        text: "Forgot Password?",
                        style: AppFonts().bodyMediumMedium.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.08),
                MyAsyncButton(
                  title: "Login",
                  onTap: controller.login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
