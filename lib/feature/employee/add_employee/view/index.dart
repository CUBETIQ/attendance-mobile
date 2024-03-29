import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/profile_image/profile_image.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/textfield/date_picker_field.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/feature/employee/add_employee/controller/index.dart';
import 'package:timesync/types/state.dart';
import 'package:timesync/utils/size_util.dart';

class AddStaffView extends StatelessWidget {
  const AddStaffView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddStaffController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => MyAppBarTitle(
            title: controller.title.value,
          ),
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
          ),
          child: Column(
            children: [
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS17, size.width)),
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
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS17, size.width)),
              MyTextFieldForm(
                hasLabel: true,
                label: "Username",
                hintText: "Enter your username",
                textController: controller.usernameController,
              ),
              SizedBox(
                height: SizeUtils.scale(
                  controller.appState.value == AppState.edit
                      ? 0
                      : AppSize().paddingS5,
                  size.width,
                ),
              ),
              controller.appState.value == AppState.edit
                  ? const SizedBox.shrink()
                  : MyTextFieldForm(
                      hasLabel: true,
                      label: "Password",
                      hintText: "Enter your password",
                      textController: controller.passwordController,
                    ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              MyTextFieldForm(
                hasLabel: true,
                label: "Email",
                hintText: "Enter your email",
                textController: controller.emailController,
              ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              Obx(
                () => MyDropDownButton<String>(
                  label: "Role",
                  value: controller.selectedRole.value,
                  hint: "Choose role",
                  dropdownItems: controller.roleList
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.capitalizeFirst),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => controller.selectedRole.value = value!,
                ),
              ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              Obx(
                () => MyDropDownButton<PositionModel>(
                  label: "Position",
                  value: controller.selectedPosition.value,
                  hint: "Choose position",
                  dropdownItems: controller.positionList
                      .map(
                        (e) => DropdownMenuItem<PositionModel>(
                          value: e,
                          child: Text(e.name?.capitalizeMaybeNull ?? ""),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectedPosition.value = value!,
                ),
              ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              Obx(
                () => MyDropDownButton<DepartmentModel>(
                  label: "Department",
                  value: controller.selectedDepartment.value,
                  hint: "Choose department",
                  dropdownItems: controller.departmentList
                      .map(
                        (e) => DropdownMenuItem<DepartmentModel>(
                          value: e,
                          child: Text(e.name.capitalizeMaybeNull ?? ""),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectedDepartment.value = value!,
                ),
              ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              MyTextFieldForm(
                hasLabel: true,
                label: "Last Name",
                hintText: "Enter your lastname",
                textController: controller.lastnameController,
              ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              MyTextFieldForm(
                hasLabel: true,
                label: "First Name",
                hintText: "Enter your firstname",
                textController: controller.firstnameController,
              ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => MyDropDownButton<String>(
                        label: "Gender",
                        value: controller.selectedGender.value,
                        hint: "Select gender",
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
                  ),
                  SizedBox(
                    width: SizeUtils.scale(size.width * 0.02, size.width),
                  ),
                  Expanded(
                    child: MyDatePickerField(
                      hasLabel: true,
                      label: "Date of birth",
                      hintText: "Select date",
                      textController: controller.dobController,
                      onDateResult: controller.getDateInMilliSecond,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              MyTextFieldForm(
                hasLabel: true,
                label: "Address",
                hintText: "Enter your address",
                textController: controller.addressController,
              ),
              SizedBox(
                  height: SizeUtils.scale(AppSize().paddingS5, size.width)),
              Obx(
                () => MyDropDownButton<String>(
                  label: "Status",
                  hint: "Choose Status",
                  value: controller.selectedStatus.value,
                  dropdownItems: controller.status
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.capitalizeFirst),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectedStatus.value = value!,
                ),
              ),
              SizedBox(height: SizeUtils.scale(30, size.width)),
              MyAsyncButton(
                title: "Save",
                margin: EdgeInsets.only(
                  bottom: SizeUtils.scale(30, size.width),
                ),
                onTap: controller.appState.value == AppState.edit
                    ? controller.onTapUpdateStaff
                    : controller.onTapAddStaff,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
