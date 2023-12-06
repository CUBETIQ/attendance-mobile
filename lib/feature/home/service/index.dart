import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/feature/home/model/check_in_model.dart';
import 'package:attendance_app/feature/home/model/check_out_model.dart';

class HomeService {
  DioUtil dioInstance = DioUtil();
  Future<AttendanceModel> checkIn(CheckInModel input) async {
    final AttendanceModel checkIn;
    final response =
        await dioInstance.dio.post(Endpoints.instance.check_in, data: {
      "checkInDateTime": input.checkInDateTime,
      "checkInStatus": input.checkInStatus,
      "checkInType": input.checkInType,
    });
    if (response.statusCode == 200) {
      checkIn = AttendanceModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Check in failed");
    }
    return checkIn;
  }

  Future<AttendanceModel> checkOut(CheckOutModel input) async {
    final AttendanceModel checkIn;
    final response =
        await dioInstance.dio.post(Endpoints.instance.check_out, data: {
      "checkOutDateTime": input.checkOutDateTime,
      "checkOutType": input.checkOutType,
      "checkOutStatus": input.checkOutStatus,
    });
    if (response.statusCode == 200) {
      checkIn = AttendanceModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Check in failed");
    }
    return checkIn;
  }
}
