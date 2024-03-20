import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/constants/image.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/feature/auth/login/controller/index.dart';
import 'package:timesync/utils/size_util.dart';

import '../../../../core/widgets/icon/svg_icon.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
              left: SizeUtils.scale(
                AppSize().paddingHorizontalLarge,
                MediaQuery.of(context).size.width,
              ),
              right: SizeUtils.scale(
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
                      Obx(
                        () => Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              SizeUtils.scale(
                                AppSize().borderRadiusMedium,
                                size.width,
                              ),
                            ),
                          ),
                          height: SizeUtils.scale(80, size.width),
                          child: controller.organization.value?.image != null &&
                                  controller.organization.value?.image
                                          ?.isNotEmpty ==
                                      true
                              ? MyCacheImage(
                                  isRounded: false,
                                  imageUrl:
                                      controller.organization.value?.image ??
                                          "",
                                  height: SizeUtils.scale(80, size.width),
                                  width: SizeUtils.scale(80, size.width),
                                  imageHeight: SizeUtils.scale(70, size.width),
                                  imageWidth: SizeUtils.scale(70, size.width),
                                )
                              : Image.asset(ImageAssets.logotimesync),
                        ),
                      ),
                      SizedBox(height: AppSize().paddingS6),
                      Obx(
                        () => MyText(
                          text:
                              controller.organization.value?.name ?? "TimeSync",
                          maxLines: 2,
                          style: AppFonts().bodyLargeMedium,
                        ),
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
                  maxLines: 2,
                  style: AppFonts().bodyMediumRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                SizedBox(height: size.height * 0.05),
                MyTextFieldForm(
                  hasLabel: true,
                  prefixWidget: SvgIcon(
                    icon: IconAssets.profile,
                    width: SizeUtils.scale(20, size.width),
                    height: SizeUtils.scale(20, size.width),
                  ),
                  label: "Username",
                  hintText: "Enter your username",
                  iconSize: SizeUtils.scale(16, size.width),
                  textController: controller.usernameController,
                ),
                SizedBox(height: size.height * 0.02),
                Obx(
                  () => MyTextFieldForm(
                    hasLabel: true,
                    isPassword: controller.showPassword.value,
                    prefixIcon: Icons.lock_rounded,
                    iconSize: SizeUtils.scale(16, size.width),
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeUtils.scale(10, size.width)),
                          child: Obx(() => MSHCheckbox(
                                value: controller.isRememberMe.value,
                                size: SizeUtils.scale(15, size.width),
                                onChanged: controller.onCheck,
                                colorConfig:
                                    MSHColorConfig.fromCheckedUncheckedDisabled(
                                  checkedColor:
                                      Theme.of(context).colorScheme.primary,
                                  uncheckedColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                style: MSHCheckboxStyle.fillScaleColor,
                              )),
                        ),
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
                SizedBox(height: SizeUtils.scale(40, size.width)),
                MyAsyncButton(
                  title: "Login",
                  onTap: controller.login,
                ),
                // SizedBox(height: SizeUtils.scale(5, size.width)),
                // MyAsyncButton(
                //   title: "Login With SSO",
                //   backgroundColor: Theme.of(context).colorScheme.secondary,
                //   onTap: controller.loginWithSSO,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
