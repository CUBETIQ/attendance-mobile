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
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

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

  Future<void> deleteCategory(String? id) async {
    try {
      await CategoryService().deleteCategory(id ?? "");
      categories.removeWhere((element) => element.id == id);
      categories.refresh();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapAddCategory() {
    Get.toNamed(
      Routes.ADD_CATEGORY,
      arguments: {"state": AppState.Create},
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
            "state": AppState.Edit,
            "category": category,
          },
        );
      },
      onTapDelete: () {
        Get.back();
        deleteCategory(category.id);
      },
    );
  }
}
