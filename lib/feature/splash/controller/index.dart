import 'package:attendance_app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final double frameRate = 70;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(Routes.LOGIN);
  }
}
