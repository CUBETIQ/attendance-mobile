import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/widgets/attachment/attachment_card.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/progress_indicator/indicator_with_percentage.dart';
import 'package:timesync/core/widgets/row/detail_row_data.dart';
import 'package:timesync/core/widgets/row/detail_row_image.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/leave/leave_detail/controller/index.dart';
import 'package:timesync/types/leave_status.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class LeaveDetailView extends StatelessWidget {
  const LeaveDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LeaveDetailController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Leave Detail",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
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
                SizedBox(
                  width: SizeUtils.scale(300, size.width),
                  child: MyText(
                    text:
                        "${controller.leave.value.type?.capitalizeMaybeNull} Leave Request",
                    style: AppFonts().bodyXXlarge.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                SizedBox(height: SizeUtils.scale(20, size.width)),
                DetailRowData(
                  title: "Type",
                  value: (controller.leave.value.type ?? "").capitalizeFirst,
                ),
                SizedBox(height: SizeUtils.scale(10, size.width)),
                DetailRowData(
                  title: "Status",
                  value: (controller.leave.value.status ?? "").capitalizeFirst,
                ),
                SizedBox(height: SizeUtils.scale(10, size.width)),
                DetailRowImage(
                  title: controller.leave.value.status == LeaveStatus.approved
                      ? "Approved By: "
                      : controller.leave.value.status == LeaveStatus.rejected
                          ? "Rejected By: "
                          : "Pending Approval: ",
                  name: StringUtil.getfullname(
                    controller.leave.value.updateBy?.firstName,
                    controller.leave.value.updateBy?.lastName,
                    controller.leave.value.updateBy?.username,
                  ),
                  image: controller.leave.value.updateBy?.image,
                ),
                SizedBox(height: SizeUtils.scale(10, size.width)),
                DetailRowData(
                  title: "Duration",
                  value:
                      " ${StringUtil.removeTrailingZeros(controller.leave.value.duration)}  ${(controller.leave.value.duration ?? 0) < 2 ? "Day" : "Days"}",
                ),
                SizedBox(height: SizeUtils.scale(10, size.width)),
                DetailRowData(
                  title: "Date",
                  value:
                      "${DateUtil.formatMillisecondsToDOB(controller.leave.value.from)} - ${DateUtil.formatMillisecondsToDOB(controller.leave.value.to)}",
                ),
                SizedBox(height: SizeUtils.scale(20, size.width)),
                const Divider(thickness: 1.5),
                MyText(text: "Reason", style: AppFonts().bodyLargeMedium),
                SizedBox(height: SizeUtils.scale(10, size.width)),
                MyText(
                  text: controller.leave.value.reason != null &&
                          controller.leave.value.reason?.isNotEmpty == true
                      ? controller.leave.value.reason!
                      : "N/A",
                  style: AppFonts().bodyMediumRegular,
                  maxLines: 20,
                ),
                SizedBox(height: SizeUtils.scale(20, size.width)),
                const Divider(thickness: 1.5),
                SizedBox(height: SizeUtils.scale(10, size.width)),
                MyText(text: "Attachment", style: AppFonts().bodyLargeMedium),
                SizedBox(height: SizeUtils.scale(10, size.width)),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.leave.value.attachment?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      RxBool fileExist = controller.checkExistFile(index).obs;
                      RxDouble progress = 0.0.obs;
                      RxBool isDownloading = false.obs;
                      final attachment =
                          controller.leave.value.attachment?[index];
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
      ),
    );
  }
}
