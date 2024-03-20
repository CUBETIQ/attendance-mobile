import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/profile_image/profile_image.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/textfield/input_date_picker_field.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/profile/edit_profile/controller/index.dart';
import 'package:timesync/utils/size_util.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.scale(
                AppSize().paddingHorizontalLarge,
                MediaQuery.of(context).size.width,
              ),
              vertical: SizeUtils.scale(
                AppSize().paddingVerticalLarge,
                MediaQuery.of(context).size.width,
              ),
            ),
            child: Column(
              children: [
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
                MyTextFieldForm(
                  hasLabel: true,
                  label: "First Name",
                  hintText: "Enter your firstname",
                  textController: controller.firstnameController,
                ),
                MyTextFieldForm(
                  hasLabel: true,
                  label: "Last Name",
                  hintText: "Enter your lastname",
                  textController: controller.lastnameController,
                ),
                Obx(
                  () => MyDropDownButton<String>(
                    label: "Gender",
                    value: controller.selectedGender.value,
                    hint: "Choose Gender",
                    dropdownItems: controller.genderList
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e.capitalizeFirst.trString),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        controller.selectedGender.value = value!,
                  ),
                ),
                InputDatePickerField(
                    type: DateFormatType.type1,
                    initialDate: DateTime.fromMillisecondsSinceEpoch(
                        controller.dob.value ??
                            DateTime.now().millisecondsSinceEpoch),
                    lastDate: DateTime.now(),
                    controller: controller.dobController,
                    onComplete: (date) {
                      controller.dob.value = date?.millisecondsSinceEpoch;
                    }),
                MyTextFieldForm(
                  hasLabel: true,
                  label: "Address",
                  hintText: "Enter your address",
                  textController: controller.addressController,
                ),
                SizedBox(height: size.height * 0.06),
                MyAsyncButton(
                  title: "Save",
                  onTap: controller.updateProfile,
                ),
              ].withSpaceBetween(
                height: SizeUtils.scale(AppSize().paddingS5, size.width),
              ),
            ),
          ),
        ));
  }
}
