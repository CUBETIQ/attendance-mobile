import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/model/summary_leave_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/leave/leave/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/utils/types_helper/state.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  static LeaveController get to => Get.find();
  RxList<LeaveModel> leave = <LeaveModel>[].obs;
  RxList<SummaryLeaveModel> summarizeLeaves = <SummaryLeaveModel>[].obs;
  var isLoading = false.obs;
  Rxn<int> startDate = Rxn<int>();
  Rxn<int> endDate = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    initFunction();
  }

  Future<void> initFunction() async {
    initDate();
    await getOwnLeave();
    getOwnSummarizeLeave();
  }

  void onRefresh() {
    initFunction();
  }

  Future<void> getOwnLeave() async {
    isLoading.value = true;
    try {
      leave.value = await LeaveService().getOwnLeave();
    } on DioException catch (e) {
      isLoading.value = false;
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOwnSummarizeLeave() async {
    try {
      summarizeLeaves.value = await LeaveService().getUserLeavSummarize(
        startDate: startDate.value,
        endDate: endDate.value,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> deleteLeave(String id) async {
    int date = DateTime.now().millisecondsSinceEpoch;
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Delete Leave Request",
        description: "Are you sure to delete this Leave Request?",
        onTapConfirm: () async {
          await LeaveService().deleteLeave(id, date);
          getOwnLeave();
          Get.back();
        },
        image: delete,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapLeave(LeaveModel leave) {
    getOptionBottomSheet(
      Get.context!,
      image: option,
      onTapEdit: () {
        Get.back();
        Get.toNamed(
          Routes.ADD_LEAVE,
          arguments: {
            "state": AppState.Edit,
            "leave": leave,
          },
        );
      },
      onTapDelete: () {
        Get.back();
        deleteLeave(leave.id!);
      },
    );
  }

  void initDate() {
    DateTime now = DateTime.now();
    startDate.value = DateTime(now.year, now.month, 1).millisecondsSinceEpoch;
    endDate.value = DateTime(now.year, now.month + 1, 0).millisecondsSinceEpoch;
  }
}
