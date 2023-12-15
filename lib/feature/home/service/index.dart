import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/feature/home/model/check_in_model.dart';
import 'package:attendance_app/feature/home/model/check_out_model.dart';
import 'package:dio/dio.dart';

class HomeService {
  DioUtil dioInstance = DioUtil();
  Future<AttendanceModel> checkIn(CheckInModel input) async {
    final AttendanceModel checkIn;

    final data = {
      "checkInDateTime": input.checkInDateTime,
      "checkInStatus": input.checkInStatus,
      "checkInType": input.checkInType,
      "checkInLocation": input.checkInLocation?.toJson(),
    };

    Response response =
        await dioInstance.dio.post(Endpoints.instance.check_in, data: data);
    if (response.statusCode == 200) {
      checkIn = AttendanceModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Check in failed");
    }
    return checkIn;
  }

  Future<AttendanceModel> checkOut(CheckOutModel input) async {
    final AttendanceModel checkIn;

    final data = {
      "checkOutDateTime": input.checkOutDateTime,
      "checkOutType": input.checkOutType,
      "checkOutStatus": input.checkOutStatus,
      "checkOutLocation": input.checkOutLocation?.toJson(),
    };

    Response response =
        await dioInstance.dio.post(Endpoints.instance.check_out, data: data);
    if (response.statusCode == 200) {
      checkIn = AttendanceModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Check in failed");
    }
    return checkIn;
  }

  Future<List<AttendanceModel>> getAttendance(
      {int? startDate, int? endDate}) async {
    List<AttendanceModel> attendanceList = [];

    final query = {
      "startDate": startDate,
      "endDate": endDate,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_attendance,
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      attendanceList = AttendanceModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return attendanceList;
  }
}
