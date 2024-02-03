import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/button/button.dart';
import 'package:timesync360/core/widgets/profile_image/profile_image.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync360/feature/department/add_department/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/types/state.dart';

class AddDepartmentViewMobile extends StatelessWidget {
  const AddDepartmentViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddDepartmentController());
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
              SizedBox(height: SizeUtils.scale(AppSize.paddingS17, size.width)),
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(
                  () => MyProfileImage(
                    imageFile: controller.imageFile.value,
                    imageUrl: controller.image.value,
                    width: SizeUtils.scale(110, size.width),
                    height: SizeUtils.scale(110, size.width),
                    imageHeight: SizeUtils.scale(70, size.width),
                    imageWidth: SizeUtils.scale(70, size.width),
                    defaultImage: SvgAssets.position,
                  ),
                ),
              ),
              SizedBox(height: SizeUtils.scale(AppSize.paddingS17, size.width)),
              MyTextFieldForm(
                hasLabel: true,
                label: "name",
                hintText: "Enter name",
                textController: controller.nameController,
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Description",
                hintText: "Enter your description",
                textController: controller.descriptionController,
                maxlines: 5,
              ),
              SizedBox(height: SizeUtils.scale(40, size.width)),
              Obx(
                () => MyButton(
                  title: "Save",
                  onTap: controller.state.value == AppState.Create
                      ? controller.addDepartment
                      : controller.updateDepartment,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
