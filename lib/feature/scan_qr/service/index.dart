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
import 'package:timesync/notification/notification_schdule.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/attendance.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/attendance_util.dart';
import 'package:timesync/utils/converter.dart';
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

  Future<void> processQR(String? url) async {
    double? lat;
    double? lng;
    if (!Validator.isValNull(url)) {
      String? decoded = fromBase64(url?.split('/').last);
      final Uri uri = Uri.parse(decoded ?? '');
      lat = double.tryParse(uri.queryParameters['lat'] ?? '');
      lng = double.tryParse(uri.queryParameters['long'] ?? '');
    }

    if (Get.isRegistered<NavigationController>()) {
      Get.offNamed(Routes.NAVIGATION);

      if (NavigationController.to.selectedIndex.value != 0) {
        NavigationController.to.selectedIndex.value = 0;
      }
      if (NavigationController.to.getUserRole.value == Role.admin) {
        HomeController.to.tabController?.animateTo(1);
      }
      QRService().postQR(lat: lat, lng: lng).then((value) async {
        if (value != null) {
          await HomeController.to.getAttendance();
          await HomeController.to.getSummarizeAttendance();
          if (Get.isRegistered<ProfileController>()) {
            ProfileController.to.getSummarizeAttendance();
          }
          if (value.checkOutDateTime == null) {
            // Set up check out reminder
            NotificationSchedule.checkOutReminder(
                time: NavigationController
                    .to.organization.value.configs?.endHour);
            // Cancel check in reminder if user check in early
            HomeController.to.cancelNotificationReminder();

            getCheckInBottomSheet(Get.context!, image: SvgAssets.working);
          } else {
            // Cancel check out reminder if user check out early
            HomeController.to.cancelNotificationReminder(checkOut: true);

            getCheckOutBottomSheet(Get.context!, image: SvgAssets.leaving);
          }
        }
      });
    }
  }

  Future<void> initDeepLink() async {
    await processQR(deepLinkUrl.value);
  }

  Future<void> uploadQR(String? url) async {
    await processQR(url);
  }

  Future<AttendanceModel?> postQR({double? lat, double? lng}) async {
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
