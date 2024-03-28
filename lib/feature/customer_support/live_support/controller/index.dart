import 'package:get/get.dart';

class LiveSupportController extends GetxController {
  static LiveSupportController get to => Get.find();

  final isError = false.obs;
  final isLoading = true.obs;
}
