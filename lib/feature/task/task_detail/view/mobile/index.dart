import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/feature/task/task_detail/controller/index.dart';
import 'package:timesync360/feature/task/task_detail/widget/detail_row_category.dart';
import 'package:timesync360/feature/task/task_detail/widget/detail_row_data.dart';
import 'package:timesync360/feature/task/task_detail/widget/detail_row_image.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDetailViewMobile extends StatelessWidget {
  const TaskDetailViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TaskDetailController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Task Detail",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeUtils.scale(20, size.width)),
              MyText(
                text: controller.task.value?.name ?? "Title",
                style: BodyXXlargeMedium,
                textAlign: TextAlign.start,
                maxLines: 5,
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              DetailRowData(
                title: "Status",
                value: controller.task.value?.status?.capitalizeFirst,
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              DetailRowImage(
                title: "Assignee",
                name: NavigationController.to.fullname.value,
                image: NavigationController.to.user.value.image,
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              DetailRowData(
                title: "Due Date",
                value: DateFormatter().formatMillisecondsToDOB(
                  controller.task.value?.endDate,
                ),
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              DetailRowData(
                title: "Priority",
                value: controller.task.value?.priority?.capitalizeFirst,
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              DetailRowCategory(
                title: "Category",
                icon: controller.task.value?.icon,
                color: controller.task.value?.color,
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              const Divider(thickness: 1.5),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              MyText(text: "Description", style: BodyLargeMedium),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              MyText(
                text: controller.task.value?.description ?? "",
                style: BodyMediumRegular,
                maxLines: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
