import 'package:attendance_app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  String title = 'splash';

  @override
  void onInit() {
    super.onInit();
    print('SplashController');
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(Routes.LOGIN);
  }
}
