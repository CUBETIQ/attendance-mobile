import 'package:attendance_app/constants/profile_image.dart';
import 'package:get/get.dart';

class AvatarController extends GetxController {
  List<String> avatars = [
    ProfileImageAssets.profileB1,
    ProfileImageAssets.profileB2,
    ProfileImageAssets.profileB3,
    ProfileImageAssets.profileB4,
    ProfileImageAssets.profileB5,
    ProfileImageAssets.profileB6,
    ProfileImageAssets.profileG1,
    ProfileImageAssets.profileG2,
    ProfileImageAssets.profileG3,
    ProfileImageAssets.profileG4,
    ProfileImageAssets.profileG5,
    ProfileImageAssets.profileG6,
  ].obs;

  void pickImage(String image) {
    Get.back(result: image);
  }
}
