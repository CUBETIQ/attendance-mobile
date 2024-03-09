import 'package:get/get.dart';
import 'package:timesync/core/model/category_model.dart';

class CategoryDetailController extends GetxController {
  static CategoryDetailController get to => Get.find();
  final categories = CategoryModel().obs;

  @override
  void onInit() {
    super.onInit();
    initArguments();
  }

  void initArguments() {
    categories.value = Get.arguments["category"];
  }
}
