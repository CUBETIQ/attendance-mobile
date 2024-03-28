import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/widgets/attachment/attachment_card.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/button/button.dart';
import 'package:timesync/core/widgets/divider/dividers.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/progress_indicator/indicator_with_percentage.dart';
import 'package:timesync/core/widgets/row/detail_row_data.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/feature/home/admin_leave_request/controller/index.dart';
import 'package:timesync/feature/home/admin_leave_request/widget/small_button.dart';
import 'package:timesync/feature/leave/leave_detail/controller/index.dart';
import 'package:timesync/types/leave.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/file_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';
import 'package:timesync/utils/validator.dart';

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
        actions: controller.hasButtons.value
            ? []
            : [
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeUtils.scale(20, size.width)),
                  child: SvgIcon(
                    icon: IconAssets.edit,
                    height: SizeUtils.scale(20, size.width),
                    width: SizeUtils.scale(20, size.width),
                  ),
                ),
              ],
      ),
      body: Container(
        height: size.height,
        color: Theme.of(context).colorScheme.inverseSurface,
        child: Padding(
          padding: EdgeInsets.all(SizeUtils.scale(20, size.width)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: DateUtil.getApplicationDuration(
                                controller.leave.value.duration),
                            style: AppFonts.TitleMedium.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          DetailRowData(
                            title: "Type",
                            value: Validator.isValNull(
                                    controller.leave.value.type)
                                ? '-'
                                : "${(controller.leave.value.type ?? "").capitalizeFirst} Type",
                            valueColor: Theme.of(context).colorScheme.primary,
                          ),
                          DetailRowData(
                            title: "Status",
                            value: StringUtil.leaveStatusSimplify(
                                    controller.leave.value.status)
                                .capitalizeFirst,
                          ),
                          controller.leave.value.status == LeaveStatus.pending
                              ? const SizedBox.shrink()
                              : DetailRowData(
                                  title: controller.leave.value.status ==
                                          LeaveStatus.approved
                                      ? "Approved By"
                                      : "Declined By",
                                  value: StringUtil.getfullname(
                                      controller
                                          .leave.value.updateBy?.firstName,
                                      controller.leave.value.updateBy?.lastName,
                                      controller
                                          .leave.value.updateBy?.username),
                                  valueColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                          DetailRowData(
                            title: "From",
                            value:
                                "${DateUtil.formatTime(DateTime.fromMillisecondsSinceEpoch(controller.leave.value.from ?? 0))} | ${DateUtil.formatMillisecondsToDOB(controller.leave.value.from)}",
                          ),
                          DetailRowData(
                            title: "To",
                            value:
                                "${DateUtil.formatTime(DateTime.fromMillisecondsSinceEpoch(controller.leave.value.to ?? 0))} | ${DateUtil.formatMillisecondsToDOB(controller.leave.value.to)}",
                          ),
                          DetailRowData(
                            title: "Duration",
                            value:
                                " ${StringUtil.removeTrailingZeros(controller.leave.value.duration)}  ${(controller.leave.value.duration ?? 0) < 2 ? "Day" : "Days"}",
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeUtils.scale(20, size.width)),
                            child: const MyDivider(),
                          ),
                        ].withSpaceBetweenNoSizedBox(
                            height: SizeUtils.scale(20, size.width)),
                      ),
                      MyText(
                          text: "Reason",
                          style: AppFonts.TitleSmall.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeUtils.scale(6, size.width)),
                        child: MyText(
                          text: controller.leave.value.reason != null &&
                                  controller.leave.value.reason?.isNotEmpty ==
                                      true
                              ? controller.leave.value.reason!
                              : "N/A",
                          style: AppFonts.LabelMedium.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                          maxLines: 20,
                        ),
                      ),
                      controller.leave.value.attachment?.isEmpty == true
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MyDivider(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeUtils.scale(10, size.width)),
                                  child: MyText(
                                      text: "Attachment",
                                      style: AppFonts().bodyLargeMedium),
                                ),
                              ],
                            ),
                      Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              controller.leave.value.attachment?.length ?? 0,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            RxBool fileExist =
                                controller.checkExistFile(index).obs;
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
                                              (value) =>
                                                  isDownloading.value = value,
                                              (value) => progress.value = value,
                                            );
                                            fileExist.value = controller
                                                .checkExistFile(index);
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
              Obx(() {
                return controller.hasButtons.value == true
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeUtils.scale(12, size.width)),
                            child: MyButton(
                              title: "Approve",
                              onTap: () => AdminLeaveRequestController.to
                                  .changeLeaveStatus(
                                      leave: controller.leave.value,
                                      status: LeaveStatus.approved),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          MyButton(
                            title: "Decline",
                            onTap: () => AdminLeaveRequestController.to
                                .changeLeaveStatus(
                                    leave: controller.leave.value,
                                    status: LeaveStatus.rejected),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        ],
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
