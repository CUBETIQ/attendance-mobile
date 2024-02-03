import 'package:timesync360/constants/organization_image.dart';
import 'package:timesync360/constants/position_image.dart';
import 'package:timesync360/constants/profile_image.dart';
import 'package:get/get.dart';
import 'package:timesync360/types/avatar_type.dart';

class AvatarController extends GetxController {
  RxList<String> avatars = <String>[].obs;
  RxString avatarType = AvatarType.profile.obs;

  @override
  void onInit() {
    super.onInit();
    initArgument();
  }

  void initArgument() {
    final data = Get.arguments;
    avatarType.value = data;
    if (avatarType.value == AvatarType.profile) {
      avatars.value = ProfileImageAssets.profileList;
    } else if (avatarType.value == AvatarType.position) {
      avatars.value = PositionImageAssets.positionList;
    } else if (avatarType.value == AvatarType.organization) {
      avatars.value = OrganizationImageAssets.organizationList;
    }
  }

  void pickImage(String image) {
    Get.back(result: image);
  }
}
