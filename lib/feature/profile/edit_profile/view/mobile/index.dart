import 'package:timesync360/config/app_size.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/button/button.dart';
import 'package:timesync360/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync360/core/widgets/profile_image/profile_image.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/textfield/date_picker_field.dart';
import 'package:timesync360/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync360/feature/profile/edit_profile/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
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
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize.paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSize.paddingS17),
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(
                  () => MyProfileImage(
                    imageFile: controller.imageFile.value,
                    imageUrl: controller.image.value,
                    width: SizeUtils.scale(110, size.width),
                    height: SizeUtils.scale(110, size.width),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.paddingS17),
              MyTextFieldForm(
                hasLabel: true,
                label: "First Name",
                hintText: "Enter your firstname",
                textController: controller.firstnameController,
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Last Name",
                hintText: "Enter your lastname",
                textController: controller.lastnameController,
              ),
              const SizedBox(height: AppSize.paddingS5),
              Obx(
                () => MyDropDownButton<String>(
                  label: "Gender",
                  value: controller.selectedGender.value,
                  hint: "Choose Gender",
                  dropdownItems: controller.genderList
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.capitalizeFirst),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectedGender.value = value!,
                ),
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyDatePickerField(
                hasLabel: true,
                label: "Date of birth",
                hintText: "Enter your date of birth",
                textController: controller.dobController,
                onDateResult: controller.getDateInMilliSecond,
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
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
