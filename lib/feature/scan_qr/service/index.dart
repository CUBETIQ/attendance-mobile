import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/attendance_method.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/attendance_util.dart';
import 'package:timesync/utils/logger.dart';
import 'package:dio/dio.dart' as dio;

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
    if (Get.isRegistered<NavigationController>()) {
      // Get.until((route) => Get.currentRoute == Routes.NAVIGATION);
      Get.offNamed(Routes.NAVIGATION);

      if (NavigationController.to.selectedIndex.value != 0) {
        NavigationController.to.selectedIndex.value = 0;
      }
      if (NavigationController.to.getUserRole.value == Role.admin) {
        HomeController.to.tabController?.animateTo(1);
      }
      QRService().scanQR().then((value) {
        if (value != null) {
          value.checkInDateTime != null
              ? getCheckInBottomSheet(Get.context!, image: SvgAssets.working)
              : getCheckOutBottomSheet(Get.context!, image: SvgAssets.leaving);
        }
      });
      // HomeController.to.isCheckedIn.value == true
      //     ? HomeController.to.checkOut()
      //     : HomeController.to.checkIn();
    }
  }

  Future<AttendanceModel?> scanQR() async {
    final AttendanceModel? result;

    DateTime now = await checkTime();
    String? startHour = HomeController.to.startHour.value;
    LocationModel location = LocationModel(
      lat: NavigationController.to.userLocation.value?.latitude,
      lng: NavigationController.to.userLocation.value?.longitude,
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

  Future<DateTime> checkTime() async {
    DateTime myTime;
    DateTime ntpTime;
    DateTime result;

    /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
    myTime = DateTime.now().toLocal();

    /// Or get NTP offset (in milliseconds) and add it yourself
    final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
    ntpTime = myTime.add(Duration(milliseconds: offset));

    if (myTime.difference(ntpTime).inMinutes > 1) {
      result = ntpTime;
    } else {
      result = myTime;
    }
    return result;
  }
}
