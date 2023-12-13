import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/textfield/texfield_validate.dart';
import 'package:attendance_app/feature/profile/edit_profile/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileViewMobile extends StatelessWidget {
  const EditProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Edit Profile",
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingHorizontalLarge,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSize.paddingS17),
              MyCacheImage(
                imageUrl: controller.user.value.image ?? "",
                width: size.width * 0.25,
                height: size.width * 0.25,
              ),
              const SizedBox(height: AppSize.paddingS17),
              MyTextFieldForm(
                hasLabel: true,
                label: "Firstname",
                hintText: "Enter your firstname",
                textController: controller.firstnameController,
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Lastname",
                hintText: "Enter your lastname",
                textController: controller.lastnameController,
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Dob",
                hintText: "Enter your date of birth",
                textController: controller.dobController,
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Address",
                hintText: "Enter your address",
                textController: controller.addressController,
              ),
              SizedBox(height: size.height * 0.06),
              MyButton(
                title: "Save",
                onTap: controller.updateProfile,
              )
            ],
          ),
        ),
      ),
    );
  }
}
