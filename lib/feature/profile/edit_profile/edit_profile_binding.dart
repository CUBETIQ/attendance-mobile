import 'package:attendance_app/feature/profile/edit_profile/controller/index.dart';
import 'package:get/get.dart';

class EditProfileBing extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}
