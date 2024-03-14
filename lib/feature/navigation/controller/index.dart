import 'package:flutter_svg/flutter_svg.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/organization_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/model/user_status_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/navigation/model/bottom_bar_model.dart';
import 'package:timesync/feature/navigation/model/drawer_model.dart';
import 'package:timesync/feature/navigation/service/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/utils/location_util.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/types/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:timesync/utils/size_util.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  final selectedIndex = 0.obs;
  final user = UserModel().obs;
  final position = PositionModel().obs;
  final department = DepartmentModel().obs;
  final getUserRole = "".obs;
  late List<DrawerModel> drawerItems;
  final titles = ['Home', 'Task', 'Profile'];
  final items = [
    BottomBarModel(
      title: 'Home',
      icon: Icons.home_rounded,
      selectedIcon: Icons.home_rounded,
      action: GestureDetector(
          onTap: () => Get.toNamed(Routes.SCANQR),
          child: SvgPicture.asset(SvgAssets.scanQR)),
    ),
    BottomBarModel(
      title: 'Report',
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart_rounded,
    ),
    BottomBarModel(
      title: 'Task',
      icon: Icons.task_rounded,
      selectedIcon: Icons.task_rounded,
    ),
    BottomBarModel(
      title: 'Leave',
      icon: Icons.work_off_rounded,
      selectedIcon: Icons.work_off_rounded,
    ),
    BottomBarModel(
      title: 'Profile',
      icon: Icons.person_rounded,
      selectedIcon: Icons.person_rounded,
      action: GestureDetector(
        onTap: () => Get.toNamed(Routes.POINT),
        child: Container(
          width: SizeUtils.scale(22, MediaQuery.of(Get.context!).size.width),
          height: SizeUtils.scale(22, MediaQuery.of(Get.context!).size.width),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            SvgAssets.coin,
          ),
        ),
      ),
    ),
  ];

  final organizationLocation = Rxn<OranizationLocationModel>(null);
  final userLocation = Rxn<Position>(null);
  final isInRange = false.obs;
  final startBreakTime = "".obs;
  final endBreakTime = "".obs;
  final organization = OrganizationModel().obs;
  final userStatus = UserStatusModel().obs;
  final fullname = Rxn<String>(null);
  final zoomDrawerController = ZoomDrawerController();
  final totalWorkMinutes = 0.obs;

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
  }

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments["user"];
    position.value = Get.arguments["position"];
    department.value = Get.arguments["department"];
    organization.value = Get.arguments["organization"];
    userStatus.value = Get.arguments["userStatus"];
    getUserRole.value = user.value.role ?? Role.staff;
    fullname.value =
        "${user.value.firstName ?? user.value.username!} ${user.value.lastName ?? ""}";
    getUserLocation();
    getOrganizationTotalWorkHour();
    initSideBarMenu();
  }

  void onDestinationSelected(int index) {
    selectedIndex.value = index;
  }

  void getOrganizationTotalWorkHour() {
    String startHour = organization.value.configs?.startHour ?? "08:00";
    String endHour = organization.value.configs?.endHour ?? "17:00";

    startBreakTime.value =
        organization.value.configs?.breakTime?.split("-")[0] ?? "12:00";
    endBreakTime.value =
        organization.value.configs?.breakTime?.split("-")[1] ?? "13:00";

    int totalMinuteBreakTime = DateUtil.calculateTotalMinutes(
        startBreakTime.value, endBreakTime.value);

    totalWorkMinutes.value =
        DateUtil.calculateTotalMinutes(startHour, endHour) -
            totalMinuteBreakTime;
  }

  Future<void> getUserLocation() async {
    organizationLocation.value = organization.value.location;
    try {
      userLocation.value = await NavigationService().getCurrentLocation();
      if (userLocation.value != null) {
        isInRange.value = isWithinRadius(userLocation.value!,
            organizationLocation.value!, AppConfig.defaultLocationRadius);
      }
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

  void onTapAddTask() {
    Get.toNamed(Routes.ADD_TASK, arguments: {"state": AppState.create});
  }

  void onTapAddLeave() {
    Get.toNamed(Routes.ADD_LEAVE, arguments: {"state": AppState.create});
  }

  void initSideBarMenu() {
    if (getUserRole.value == Role.admin) {
      drawerItems = [
        DrawerModel(
          title: "Organization",
          icon: Icons.home_rounded,
          onTap: () {
            Get.toNamed(Routes.ORGANIZATION);
          },
        ),
        DrawerModel(
          title: "Employee",
          icon: Icons.person_rounded,
          onTap: () {
            Get.toNamed(Routes.STAFF);
          },
        ),
        DrawerModel(
          title: "Position",
          icon: Icons.work_rounded,
          onTap: () {
            Get.toNamed(Routes.POSITION);
          },
        ),
        DrawerModel(
          title: "Department",
          icon: Icons.location_city_rounded,
          onTap: () {
            Get.toNamed(Routes.DEPARTMENT);
          },
        ),
        DrawerModel(
          title: "Category",
          icon: Icons.category_rounded,
          onTap: () {
            Get.toNamed(Routes.CATEGORY);
          },
        ),
        DrawerModel(
          title: "Support",
          icon: Icons.support_agent_rounded,
          onTap: () {
            Get.toNamed(Routes.CUSTOMER_SUPPORT);
          },
        ),
        DrawerModel(
          title: "Setting",
          icon: Icons.settings_rounded,
          onTap: () {
            Get.toNamed(Routes.SETTING);
          },
        ),
        DrawerModel(
          title: "Log out",
          icon: Icons.logout_rounded,
          onTap: () {
            getLogOutBottomSheet(
              Get.context!,
              image: SvgAssets.leaving,
              onTapLogOut: () async {
                await IsarService().clearLocalData(deleteToken: true);
                Get.offNamed(
                  Routes.LOGIN,
                  arguments: {"organization": organization.value},
                );
              },
            );
          },
        ),
      ];
    } else {
      drawerItems = [
        DrawerModel(
          title: "Setting",
          icon: Icons.settings_rounded,
          onTap: () {
            Get.toNamed(Routes.SETTING);
          },
        ),
        DrawerModel(
          title: "Support",
          icon: Icons.headset_mic_rounded,
          onTap: () {
            Get.toNamed(Routes.CUSTOMER_SUPPORT);
          },
        ),
        DrawerModel(
          title: "Log out",
          icon: Icons.logout_rounded,
          onTap: () async {
            getLogOutBottomSheet(
              Get.context!,
              image: SvgAssets.leaving,
              onTapLogOut: () async {
                await IsarService().clearLocalData(deleteToken: true);
                Get.offNamed(
                  Routes.LOGIN,
                  arguments: {"organization": organization.value},
                );
              },
            );
          },
        ),
      ];
    }
  }
}
