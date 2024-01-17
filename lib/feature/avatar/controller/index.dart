import 'package:attendance_app/constants/profile_image.dart';
import 'package:get/get.dart';

class AvatarController extends GetxController {
  List<String> avatars = [
    profileB1,
    profileB2,
    profileB3,
    profileB4,
    profileB5,
    profileB6,
    profileG1,
    profileG2,
    profileG3,
    profileG4,
    profileG5,
    profileG6,
  ].obs;

  void pickImage(String image) {
    Get.back(result: image);
  }
}
