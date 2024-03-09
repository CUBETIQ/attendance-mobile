import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/position/position/service/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/state.dart';
import '../../../../constants/svg.dart';

class PositionController extends GetxController {
  static PositionController get to => Get.find();
  final positionList = <PositionModel>[].obs;
  final positionListBackUp = <PositionModel>[].obs;
  final searchController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllPositions();
  }

  Future<void> onRefresh() async {
    await getAllPositions();
  }

  Future<void> getAllPositions() async {
    isLoading.value = true;
    try {
      positionListBackUp.value = await PositionService().getAllPosition(
          organizationId: NavigationController.to.organization.value.id ?? "");
      positionList.value = positionListBackUp.value;
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePosition(String id) async {
    try {
      await PositionService().deletePosition(id);
      positionListBackUp.value.removeWhere((element) => element.id == id);
      positionList.value = positionListBackUp.value;
      positionListBackUp.refresh();
      positionList.refresh();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapPosition(PositionModel position) {
    getEditAndDeleteBottomSheet(
      Get.context!,
      image: SvgAssets.option,
      onTapEdit: () {
        Get.toNamed(
          Routes.ADD_POSITION,
          arguments: {
            "state": AppState.edit,
            "position": position,
          },
        );
        Get.back();
      },
      onTapDelete: () async {
        await deletePosition(position.id ?? "");
        Get.back();
      },
    );
  }

  void onTapViewDetail(PositionModel position) {
    Get.toNamed(
      Routes.POSITION_DETAIL,
      arguments: position,
    );
  }

  void onTapAddPosition() {
    Get.toNamed(Routes.ADD_POSITION, arguments: {"state": AppState.create});
  }

  void searchPosition(String value) {
    if (value.isEmpty) {
      positionList.value = positionListBackUp.value;
    } else {
      positionList.value = positionListBackUp.value.where((element) {
        return (element.name?.toLowerCase().contains(value.toLowerCase()) ??
            false);
      }).toList();
    }
  }

  void clearSearch() {
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      positionList.value = positionListBackUp.value;
    }
  }
}
