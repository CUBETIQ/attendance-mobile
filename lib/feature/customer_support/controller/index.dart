import 'package:attendance_app/feature/customer_support/model/support_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSupportController extends GetxController {
  static CustomerSupportController get to => Get.find();

  List<SupportButtonModel> buttons = [
    SupportButtonModel(
      title: 'Email',
      leadingIcon: Icons.email_rounded,
      trailingIcon: Icons.arrow_forward_ios_rounded,
      onTap: () {},
    ),
    SupportButtonModel(
      title: 'Phone',
      leadingIcon: Icons.phone_rounded,
      trailingIcon: Icons.arrow_forward_ios_rounded,
      onTap: () {},
    ),
    SupportButtonModel(
      title: 'Chat',
      leadingIcon: Icons.chat_rounded,
      trailingIcon: Icons.arrow_forward_ios_rounded,
      onTap: () {},
    ),
  ];
}
