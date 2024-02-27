import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/model/category_model.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/category/category/service/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/types/state.dart';

class CategoryController extends GetxController {
  static CategoryController get to => Get.find();
  final categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllCategory();
  }

  Future<void> onRefresh() async {
    await getAllCategory();
  }

  Future<void> getAllCategory() async {
    try {
      categories.value = await CategoryService().getAllCategory(
        NavigationController.to.organization.value.id ?? "",
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> deleteCategory(CategoryModel? data) async {
    if (data?.organizationId == null) {
      showWarningSnackBar("Warning", "You cannot delete this category");
      return;
    }
    try {
      await CategoryService().deleteCategory(data?.id ?? "");
      categories.removeWhere((element) => element.id == data?.id);
      categories.refresh();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      return;
    }
  }

  void onTapAddCategory() {
    Get.toNamed(
      Routes.ADD_CATEGORY,
      arguments: {"state": AppState.create},
    );
  }

  void onTapCategory(CategoryModel category) {
    getEditDeleteViewBottomSheet(
      Get.context!,
      image: SvgAssets.option,
      onTapView: () {
        Get.back();
        Get.toNamed(
          Routes.CATEGORY_DETAIL,
          arguments: {
            "category": category,
          },
        );
      },
      onTapEdit: () {
        Get.back();
        Get.toNamed(
          Routes.ADD_CATEGORY,
          arguments: {
            "state": AppState.edit,
            "category": category,
          },
        );
      },
      onTapDelete: () {
        Get.back();
        deleteCategory(category);
      },
    );
  }
}
