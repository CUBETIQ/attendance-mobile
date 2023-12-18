import 'package:attendance_app/config/app_config.dart';
import 'package:attendance_app/core/model/department_model.dart';
import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/model/bottom_bar_model.dart';
import 'package:attendance_app/feature/navigation/service/index.dart';
import 'package:attendance_app/utils/location_util.dart';
import 'package:attendance_app/utils/types_helper/role.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  RxInt selectedIndex = 0.obs;
  Rx<UserModel> user = UserModel().obs;
  Rx<PositionModel> position = PositionModel().obs;
  Rx<DepartmentModel> department = DepartmentModel().obs;
  RxString getUserRole = "".obs;
  List<String> titles = ['Home', 'Task', 'Profile'];
  List<BottomBarModel> items = [
    BottomBarModel(
      title: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
    ),
    BottomBarModel(
      title: 'Task',
      icon: Icons.task_outlined,
      selectedIcon: Icons.task_rounded,
    ),
    BottomBarModel(
      title: 'Profile',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
    ),
  ];
  Rxn<OranizationLocationModel> organizationLocation =
      Rxn<OranizationLocationModel>(null);
  Rxn<Position> userLocation = Rxn<Position>(null);
  RxBool isInRange = false.obs;
  Rxn<String> startBreakTime = Rxn<String>(null);
  Rxn<String> endBreakTime = Rxn<String>(null);
  Rx<OrganizationModel> organization = OrganizationModel().obs;

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments["user"];
    position.value = Get.arguments["position"];
    department.value = Get.arguments["department"];
    organization.value = Get.arguments["organization"];
    getUserRole.value = user.value.role ?? Role.staff;
    getUserLocation();
  }

  void onDestinationSelected(int index) {
    selectedIndex.value = index;
  }

  Future<void> getUserLocation() async {
    organizationLocation.value = organization.value.location;
    startBreakTime.value = organization.value.configs?.breakTime?.split("-")[0];
    endBreakTime.value = organization.value.configs?.breakTime?.split("-")[1];
    try {
      userLocation.value = await NavigationService().getCurrentLocation();
      isInRange.value = isWithinRadius(userLocation.value!,
          organizationLocation.value!, AppConfig.DEFAULT_LOCATION_RADIUS);
    } on Exception catch (e) {
      showErrorSnackBar("Error", e.toString());
      rethrow;
    }
  }

  Future<void> fetchMe() async {
    try {
      user.value = await NavigationService().fetchMe();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
