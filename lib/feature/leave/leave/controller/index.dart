import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/leave_model.dart';
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
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getOwnLeave();
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

  Future<void> deleteLeave(String id) async {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Delete Leave Request",
        description: "Are you sure to delete this Leave Request?",
        onTapConfirm: () async {
          await LeaveService().deleteLeave(id);
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
}
