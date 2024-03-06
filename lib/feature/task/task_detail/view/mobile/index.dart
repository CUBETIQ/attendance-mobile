import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/attachment_model.dart';
import 'package:timesync360/core/widgets/attachment/attachment_card.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/progress_indicator/indicator_with_percentage.dart';
import 'package:timesync360/core/widgets/row/detail_row_category.dart';
import 'package:timesync360/core/widgets/row/detail_row_data.dart';
import 'package:timesync360/core/widgets/row/detail_row_image.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/feature/task/task_detail/controller/index.dart';
import 'package:timesync360/utils/file_util.dart';
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
            horizontal: SizeUtils.scaleMobile(
              AppSize().paddingHorizontalLarge,
              size.width,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
              MyText(
                text: controller.task.value?.name ?? "Title",
                style: AppFonts().bodyXXlargeMedium.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.start,
                maxLines: 5,
              ),
              SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
              DetailRowData(
                title: "Status",
                value: controller.task.value?.status?.capitalizeFirst,
              ),
              SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
              DetailRowImage(
                title: "Assignee",
                name: NavigationController.to.fullname.value,
                image: NavigationController.to.user.value.image,
              ),
              SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
              DetailRowData(
                title: "Due",
                value: DateFormatter.formatMillisecondsToDOB(
                  controller.task.value?.endDate,
                ),
              ),
              SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
              DetailRowData(
                title: "Priority",
                value: controller.task.value?.priority?.capitalizeFirst,
              ),
              SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
              DetailRowCategory(
                title: "Category",
                icon: controller.task.value?.icon,
              ),
              SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
              const Divider(thickness: 1.5),
              SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
              MyText(text: "Description", style: AppFonts().bodyLargeMedium),
              SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
              MyText(
                text: controller.task.value?.description != null &&
                        controller.task.value?.description?.isNotEmpty == true
                    ? controller.task.value!.description!
                    : "N/A",
                style: AppFonts().bodyMediumRegular,
                maxLines: 20,
              ),
              SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
              const Divider(thickness: 1.5),
              SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
              MyText(text: "Attachment", style: AppFonts().bodyLargeMedium),
              SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
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
