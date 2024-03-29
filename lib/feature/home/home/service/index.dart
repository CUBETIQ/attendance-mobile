import 'package:timesync/core/model/attendance_chart_model.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/summary_attendance_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/model/user_status_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/feature/home/home/model/check_in_model.dart';
import 'package:timesync/feature/home/home/model/check_out_model.dart';
import 'package:timesync/feature/home/home/model/update_user_status_model.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

class HomeService {
  static final _singleton = HomeService._internal();
  final dioInstance = DioUtil();

  factory HomeService() {
    return _singleton;
  }

  HomeService._internal() {
    Logs.t('[HomeService] Initialized');
  }

  Future<AttendanceModel> checkIn(CheckInModel input) async {
    final AttendanceModel? checkIn;

    final data = {
      "checkInDateTime": input.checkInDateTime,
      "checkInStatus": input.checkInStatus,
      "checkInType": input.checkInType,
      "checkInEarly": input.checkInEarly,
      "checkInLate": input.checkInLate,
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

  Future<List<PositionModel>> getAllPosition(
      {required String organizationId}) async {
    final List<PositionModel>? positions;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_position,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      positions = PositionModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get All Position failed");
    }
    return positions;
  }

  Future<List<UserModel>> getAllStaffs({required String organizationId}) async {
    final List<UserModel> staffs;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.staff,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      staffs = UserModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get all staff failed");
    }
    return staffs;
  }

  Future<AttendanceModel> checkOut(CheckOutModel input) async {
    final AttendanceModel? checkIn;

    final data = {
      "checkOutDateTime": input.checkOutDateTime,
      "checkOutType": input.checkOutType,
      "checkOutStatus": input.checkOutStatus,
      "checkOutEarly": input.checkOutEarly,
      "checkOutLate": input.checkOutLate,
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

  Future<AttendanceModel> breakTime(int date) async {
    final AttendanceModel? attendance;

    Response response = await dioInstance.dio
        .post(Endpoints.instance.break_time, data: {"date": date});
    if (response.statusCode == 200) {
      attendance = AttendanceModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Start/End break time failed");
    }
    return attendance;
  }

  Future<List<AttendanceModel>> getAttendance(
      {int? startDate, int? endDate}) async {
    List<AttendanceModel>? attendanceList = [];

    final query = {
      "startDate": startDate,
      "endDate": endDate,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_attendance,
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      attendanceList = AttendanceModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return attendanceList;
  }

  Future<List<SummaryAttendanceModel>> getSummrizeAttendance(
      {required int startDate, required int endDate}) async {
    List<SummaryAttendanceModel>? summaryAttendance;

    final query = {
      "startDate": startDate,
      "endDate": endDate,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_summary_attendance,
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      summaryAttendance =
          SummaryAttendanceModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return summaryAttendance;
  }

  Future<List<AttendanceChartModel>> getAttendanceChart(
      {int? startDate, int? endDate, required String organizationId}) async {
    List<AttendanceChartModel>? attendanceChart;

    Map<String, dynamic> query = {
      "startDate": startDate,
      "endDate": endDate,
      "organizationId": organizationId,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_dashboard_chart,
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      attendanceChart =
          AttendanceChartModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return attendanceChart;
  }

  Future<List<AttendanceModel>> getAllStaffAttendance({
    int? startDate,
    int? endDate,
    required String organizationId,
  }) async {
    List<AttendanceModel>? attendanceList;

    Map<String, dynamic> query = {
      "startDate": startDate,
      "endDate": endDate,
      "organizationId": organizationId,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_all_staff_attendance,
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      attendanceList = AttendanceModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get attendance failed");
    }
    return attendanceList;
  }

  Future<UserStatusModel> updateUserStatus(UpdateUserStatusModel input) async {
    final UserStatusModel? status;

    Map<String, dynamic> data = {
      "status": input.status,
      "lastUpdatedAt": input.lastUpdatedAt,
    };

    Response response = await dioInstance.dio.put(
      Endpoints.instance.user_status,
      data: data,
    );

    if (response.statusCode == 200) {
      status = UserStatusModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Get user status failed");
    }

    return status;
  }
}
