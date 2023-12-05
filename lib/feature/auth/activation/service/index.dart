import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/auth/activation/model/activation_model.dart';
import 'package:dio/dio.dart';

class ActivationService {
  DioUtil dioInstance = DioUtil();

  Future<bool> activate(ActivationModel input) async {
    Response response = await dioInstance.dio.post(
      Endpoints.instance.activation,
      data: {
        "code": input.code,
        "device": input.device,
      },
    );
    if (response.statusCode == 200) {
      showSuccessSnackBar("Success", response.data["message"]);
      return true;
    } else {
      throw Exception("Activation failed");
    }
  }
}
