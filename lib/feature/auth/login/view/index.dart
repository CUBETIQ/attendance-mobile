import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/constants/image.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/check_box/check_box.dart';
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
          clipBehavior: Clip.none,
          child: Padding(
            padding: EdgeInsets.only(
              top: SizeUtils.scale(44, size.width),
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
                          width: SizeUtils.scale(100, size.width),
                          height: SizeUtils.scale(100, size.width),
                          child: controller.organization.value?.image != null &&
                                  controller.organization.value?.image
                                          ?.isNotEmpty ==
                                      true
                              ? MyCacheImage(
                                  isRounded: false,
                                  imageUrl:
                                      controller.organization.value?.image ??
                                          "",
                                  height: SizeUtils.scale(100, size.width),
                                  width: SizeUtils.scale(100, size.width),
                                  imageHeight: SizeUtils.scale(90, size.width),
                                  imageWidth: SizeUtils.scale(90, size.width),
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
                  hasLabel: false,
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
                SizedBox(height: SizeUtils.scale(16, size.width)),
                Obx(
                  () => MyTextFieldForm(
                    hasLabel: false,
                    isPassword: controller.showPassword.value,
                    prefixWidget: SvgIcon(
                      icon: IconAssets.lock,
                      width: SizeUtils.scale(20, size.width),
                      height: SizeUtils.scale(20, size.width),
                    ),
                    iconSize: SizeUtils.scale(16, size.width),
                    label: "Password",
                    hintText: "Enter your password",
                    textController: controller.passwordController,
                    haveSuffixIcon: true,
                    onTapShowPassword: controller.onTapShowPassword,
                  ),
                ),
                SizedBox(height: SizeUtils.scale(16, size.width)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => MyCheckBox(
                            isChecked: controller.isRememberMe.value,
                            onTap: controller.onCheckRememberMe,
                          ),
                        ),
                        SizedBox(width: SizeUtils.scale(6, size.width)),
                        MyText(
                          text: "Remember me",
                          style: AppFonts.LabelSmall,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: null,
                      child: MyText(
                        text: "Forgot Password?",
                        style: AppFonts.LabelSmall.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
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
          title: "Login",
          onTap: controller.login,
        ),
      ),
    );
  }
}
