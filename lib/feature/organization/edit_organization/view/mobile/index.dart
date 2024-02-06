import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/core/widgets/button/async_button.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/profile_image/profile_image.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync360/core/widgets/textfield/time_picker_field.dart';
import 'package:timesync360/feature/organization/edit_organization/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
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
              AppSize().paddingHorizontalLarge,
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
                    imageHeight: SizeUtils.scale(80, size.width),
                    imageWidth: SizeUtils.scale(80, size.width),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              MyTextFieldForm(
                hasLabel: true,
                label: "Name",
                hintText: "Enter your organization name",
                textController: controller.nameController,
              ),
              SizedBox(height: AppSize().paddingS5),
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
              SizedBox(height: AppSize().paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Address",
                hintText: "Enter your organization address",
                textController: controller.addressController,
              ),
              SizedBox(height: AppSize().paddingS5),
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
              SizedBox(height: AppSize().paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Description",
                hintText: "Enter your description",
                textController: controller.descriptionController,
                maxlines: 5,
              ),
              SizedBox(height: SizeUtils.scale(30, size.width)),
              MyAsyncButton(
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
