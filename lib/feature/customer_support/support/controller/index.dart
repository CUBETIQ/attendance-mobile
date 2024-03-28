import 'package:timesync/feature/customer_support/support/model/support_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/routes/app_pages.dart';

class CustomerSupportController extends GetxController {
  static CustomerSupportController get to => Get.find();

  final buttons = [
    SupportButtonModel(
      title: 'Contact Live Chat',
      leadingIcon: Icons.support_agent_rounded,
      trailingIcon: Icons.arrow_forward_ios_rounded,
      onTap: () {
        Get.toNamed(Routes.LIVE_SUPPORT);
      },
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
