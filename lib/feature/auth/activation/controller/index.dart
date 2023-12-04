import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivationController extends GetxController {
  static ActivationController get to => Get.find();
  TextEditingController activationController = TextEditingController();
  final String title = "Please enter the activation code";
  final String description =
      "To unlock the flow of time with Time Glitch: Where every moment counts, and attendance becomes a seamless journey through the fabric of efficiency.";

  Future<void> activation() async {
    try {} on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
