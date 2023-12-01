import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  RxInt selectedIndex = 0.obs;
  List<String> titles = ['Home', 'Notifications', 'Messages'];

  void onDestinationSelected(int index) {
    selectedIndex.value = index;
  }
}
