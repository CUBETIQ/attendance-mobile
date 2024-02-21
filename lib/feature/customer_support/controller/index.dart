import 'package:timesync360/feature/customer_support/model/support_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSupportController extends GetxController {
  static CustomerSupportController get to => Get.find();

  final buttons = [
    SupportButtonModel(
      title: 'Contact Live Chat',
      leadingIcon: Icons.support_agent_rounded,
      trailingIcon: Icons.arrow_forward_ios_rounded,
      onTap: () {},
    ),
    SupportButtonModel(
      title: 'Send Us An Email',
      leadingIcon: Icons.email_rounded,
      trailingIcon: Icons.arrow_forward_ios_rounded,
      onTap: () {},
    ),
    SupportButtonModel(
      title: 'FAQs',
      leadingIcon: Icons.help_rounded,
      trailingIcon: Icons.arrow_forward_ios_rounded,
      onTap: () {},
    ),
  ];
}
