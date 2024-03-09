import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/feature/auth/change_password/controller/index.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangePasswordViewMobile extends StatelessWidget {
  const ChangePasswordViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Change Password",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scaleMobile(
                AppSize().paddingHorizontalLarge, size.width),
            vertical: SizeUtils.scaleMobile(
                AppSize().paddingVerticalLarge, size.height),
          ),
          child: Column(
            children: [
              SizedBox(
                width: SizeUtils.scaleMobile(200, size.width),
                height: SizeUtils.scaleMobile(140, size.width),
                child: SvgPicture.asset(SvgAssets.password),
              ),
              SizedBox(
                height: SizeUtils.scaleMobile(10, size.height),
              ),
              MyText(
                maxLines: 2,
                textAlign: TextAlign.center,
                text: "To change your password, Please enter the detail below",
                style: AppFonts().bodyMediumRegular,
              ),
              SizedBox(
                height: SizeUtils.scaleMobile(10, size.height),
              ),
              controller.isChangeStaffPass.value == true
                  ? const SizedBox.shrink()
                  : Obx(
                      () => MyTextFieldForm(
                        label: "Old Password",
                        prefixIcon: Icons.lock_rounded,
                        hintText: "Enter old password",
                        textController: controller.oldPasswordController,
                        hasLabel: true,
                        isPassword: controller.hideOldPassword.value,
                        onTapShowPassword: controller.onTapShowOldPassword,
                        haveSuffixIcon: true,
                      ),
                    ),
              SizedBox(
                height: SizeUtils.scaleMobile(5, size.height),
              ),
              Obx(
                () => MyTextFieldForm(
                  label: "New Password",
                  prefixIcon: Icons.lock_rounded,
                  textController: controller.newPasswordController,
                  hintText: "Enter new password",
                  hasLabel: true,
                  isPassword: controller.hideNewPassword.value,
                  onTapShowPassword: controller.onTapShowNewPassword,
                  haveSuffixIcon: true,
                ),
              ),
              SizedBox(
                height: SizeUtils.scaleMobile(10, size.height),
              ),
              MyAsyncButton(
                onTap: controller.isChangeStaffPass.value == true
                    ? controller.changeStaffPassword
                    : controller.changeUserPassword,
                title: "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
