import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/profile_image/profile_image.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/textfield/texfield_validate.dart';
import 'package:attendance_app/core/widgets/textfield/time_picker_field.dart';
import 'package:attendance_app/feature/organization/edit_organization/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditOrganizationViewMobile extends StatelessWidget {
  const EditOrganizationViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditOrganizationController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(title: "Edit Organization"),
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
              size.width,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: SizeUtils.scale(30, size.width)),
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
                label: "Name",
                hintText: "Enter your organization name",
                textController: controller.nameController,
              ),
              const SizedBox(height: AppSize.paddingS5),
              Row(
                children: [
                  Expanded(
                    child: MyTimePickerField(
                      label: "Start Time",
                      hasLabel: true,
                      textController: controller.startHourController,
                      onDateResult: (value) {},
                    ),
                  ),
                  SizedBox(
                    width: SizeUtils.scale(10, size.width),
                  ),
                  Expanded(
                    child: MyTimePickerField(
                      label: "End Time",
                      hasLabel: true,
                      textController: controller.endHourController,
                      onDateResult: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Address",
                hintText: "Enter your organization address",
                textController: controller.addressController,
              ),
              const SizedBox(height: AppSize.paddingS5),
              Row(
                children: [
                  Expanded(
                    child: MyTimePickerField(
                      label: "Start Break Time",
                      hasLabel: true,
                      textController: controller.breakStartHourController,
                      onDateResult: (value) {},
                    ),
                  ),
                  SizedBox(
                    width: SizeUtils.scale(10, size.width),
                  ),
                  Expanded(
                    child: MyTimePickerField(
                      label: "End Break Time",
                      hasLabel: true,
                      textController: controller.breakEndHourController,
                      onDateResult: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Description",
                hintText: "Enter your description",
                textController: controller.descriptionController,
                maxlines: 5,
              ),
              SizedBox(height: SizeUtils.scale(30, size.width)),
              MyButton(
                title: "Save",
                onTap: controller.updateOrganization,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
