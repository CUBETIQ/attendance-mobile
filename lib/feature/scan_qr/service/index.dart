import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/profile/profile/controller/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/attendance_method.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/attendance_util.dart';
import 'package:timesync/utils/logger.dart';
import 'package:timesync/utils/validator.dart';

class QRService {
  static final _singleton = QRService._internal();
  final dioInstance = DioUtil();

  factory QRService() {
    return _singleton;
  }

  QRService._internal() {
    Logs.t('[QRService] Initialized');
  }

  final deepLinkUrl = Rxn<String>(null);

  Future<void> initDeepLink() async {
    double? lat;
    double? lng;
    if (!Validator.isValNull(deepLinkUrl.value)) {
      
      final Uri uri = Uri.parse(deepLinkUrl.value ?? '');
      lat = double.tryParse(uri.queryParameters['lat'] ?? '');
      lng = double.tryParse(uri.queryParameters['long'] ?? '');
    }

    if (Get.isRegistered<NavigationController>()) {
      // Get.until((route) => Get.currentRoute == Routes.NAVIGATION);
      Get.offNamed(Routes.NAVIGATION);

      if (NavigationController.to.selectedIndex.value != 0) {
        NavigationController.to.selectedIndex.value = 0;
      }
      if (NavigationController.to.getUserRole.value == Role.admin) {
        HomeController.to.tabController?.animateTo(1);
      }
      QRService().scanQR(lat: lat, lng: lng).then((value) async {
        if (value != null) {
          await HomeController.to.getAttendance();
          await HomeController.to.getSummarizeAttendance();
          if (Get.isRegistered<ProfileController>()) {
            ProfileController.to.getSummarizeAttendance();
          }
          if (value.checkOutDateTime == null) {
            getCheckInBottomSheet(Get.context!, image: SvgAssets.working);
          } else {
            getCheckOutBottomSheet(Get.context!, image: SvgAssets.leaving);
          }
        }
      });
    }
  }

  Future<AttendanceModel?> scanQR({double? lat, double? lng}) async {
    final AttendanceModel? result;

    DateTime now = await HomeController.to.checkTime();
    String? startHour = HomeController.to.startHour.value;
    LocationModel location = LocationModel(
      lat: lat ?? NavigationController.to.userLocation.value?.latitude,
      lng: lng ?? NavigationController.to.userLocation.value?.longitude,
      inOffice: NavigationController.to.isInRange.value,
    );

    final data = {
      "dateTime": now.millisecondsSinceEpoch,
      "status": CheckInStatusValidator.getStatus(startHour, now),
      "type": AttendanceMethod.qrCode,
      "early": GetMinute.checkEarlyMinute(startHour, now),
      "late": GetMinute.checkLateMinute(startHour, now),
      "location": location,
    };

    dio.Response response =
        await dioInstance.dio.post(Endpoints.instance.scan_qr, data: data);
    if (response.statusCode == 200) {
      result = AttendanceModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Scan QR failed");
    }
    return result;
  }
}
