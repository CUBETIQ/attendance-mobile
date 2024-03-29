import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/widgets/attachment/attachment_card.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/divider/dividers.dart';
import 'package:timesync/core/widgets/progress_indicator/indicator_with_percentage.dart';
import 'package:timesync/core/widgets/row/detail_row_category.dart';
import 'package:timesync/core/widgets/row/detail_row_data.dart';
import 'package:timesync/core/widgets/row/detail_row_image.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/task/task_detail/controller/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/state.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({super.key});

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit_rounded,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onPressed: () {
              Get.toNamed(Routes.ADD_TASK, arguments: {
                "state": AppState.edit,
                "task": controller.task.value,
              });
            },
          ),
        ],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeUtils.scale(20, size.width)),
              MyText(
                text: controller.task.value?.name ?? "Title",
                style: AppFonts().bodyXXlargeMedium.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
                name: controller.user.value != null
                    ? StringUtil.getfullname(
                        controller.user.value?.firstName,
                        controller.user.value?.lastName,
                        controller.user.value?.username,
                      )
                    : NavigationController.to.fullname.value,
                image: controller.user.value != null
                    ? controller.user.value?.image
                    : NavigationController.to.user.value.image,
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              DetailRowData(
                title: "Start",
                value: DateUtil.formatMillisecondsToDOB(
                  controller.task.value?.startDate,
                ),
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              DetailRowData(
                title: "Due",
                value: DateUtil.formatMillisecondsToDOB(
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
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              const MyDivider(),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              MyText(text: "Description", style: AppFonts().bodyLargeMedium),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              MyText(
                text: controller.task.value?.description != null &&
                        controller.task.value?.description?.isNotEmpty == true
                    ? controller.task.value!.description!
                    : "-",
                style: AppFonts().bodyMediumRegular,
                maxLines: 20,
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              controller.task.value?.attachment?.isEmpty == true
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        const MyDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeUtils.scale(10, size.width)),
                          child: MyText(
                              text: "Attachment",
                              style: AppFonts().bodyLargeMedium),
                        ),
                      ],
                    ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.task.value?.attachment?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    RxBool fileExist = controller.checkExistFile(index).obs;
                    RxDouble progress = 0.0.obs;
                    RxBool isDownloading = false.obs;
                    final attachment =
                        controller.task.value?.attachment?[index];
                    return Obx(
                      () => AttachmentCard(
                        data: attachment ?? AttachmentModel(),
                        trailing: isDownloading.value
                            ? ProgressIndicatorWithPercentage(
                                percentage: progress.value,
                              )
                            : null,
                        icon: fileExist.value
                            ? Icons.visibility_rounded
                            : Icons.download_rounded,
                        onTapIcon: isDownloading.value
                            ? null
                            : fileExist.value
                                ? () async {
                                    await FileUtil.openFile(
                                      attachment?.name ?? "",
                                    );
                                  }
                                : () async {
                                    await FileUtil.downloadFile(
                                      attachment?.name ?? "",
                                      attachment?.url ?? "",
                                      isDownloading.value,
                                      progress.value,
                                      (value) => isDownloading.value = value,
                                      (value) => progress.value = value,
                                    );
                                    fileExist.value =
                                        controller.checkExistFile(index);
                                  },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
