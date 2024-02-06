import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:timesync360/core/model/category_model.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/category/category/service/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/types/state.dart';

class CategoryController extends GetxController {
  static CategoryController get to => Get.find();
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

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

  void onTapAddCategory() {
    Get.toNamed(
      Routes.ADD_CATEGORY,
      arguments: {"state": AppState.Create},
    );
  }
}
